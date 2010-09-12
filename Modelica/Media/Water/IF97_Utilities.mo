within Modelica.Media.Water;
package IF97_Utilities
  "Low level and utility computation for high accuracy water properties according to the IAPWS/IF97 standard"

  extends Modelica.Icons.Package;

  package BaseIF97
    "Modelica Physical Property Model: the new industrial formulation IAPWS-IF97"
    extends Modelica.Icons.Package;
    record IterationData "constants for iterations internal to some functions"

      extends Modelica.Icons.Record;
      constant Integer IMAX=50
        "maximum number of iterations for inverse functions";
      constant Real DELP=1.0e-6 "maximum iteration error in pressure, Pa";
      constant Real DELS=1.0e-8
        "maximum iteration error in specific entropy, J/{kg.K}";
      constant Real DELH=1.0e-8
        "maximum iteration error in specific entthalpy, J/kg";
      constant Real DELD=1.0e-8 "maximum iteration error in density, kg/m^3";
    end IterationData;

    //===================================================================
    //                      Constant declarations

    //===================================================================
    record data "constant IF97 data and region limits"
      extends Modelica.Icons.Record;
      constant SI.SpecificHeatCapacity RH2O=461.526
        "specific gas constant of water vapour";
      constant SI.MolarMass MH2O=0.01801528 "molar weight of water";
      constant SI.Temperature TSTAR1=1386.0
        "normalization temperature for region 1 IF97";
      constant SI.Pressure PSTAR1=16.53e6
        "normalization pressure for region 1 IF97";
      constant SI.Temperature TSTAR2=540.0
        "normalization temperature for region 2 IF97";
      constant SI.Pressure PSTAR2=1.0e6
        "normalization pressure for region 2 IF97";
      constant SI.Temperature TSTAR5=1000.0
        "normalization temperature for region 5 IF97";
      constant SI.Pressure PSTAR5=1.0e6
        "normalization pressure for region 5 IF97";
      constant SI.SpecificEnthalpy HSTAR1=2.5e6
        "normalization specific enthalpy for region 1 IF97";
      constant Real IPSTAR=1.0e-6
        "normalization pressure for inverse function in region 2 IF97";
      constant Real IHSTAR=5.0e-7
        "normalization specific enthalpy for inverse function in region 2 IF97";
      constant SI.Temperature TLIMIT1=623.15
        "temperature limit between regions 1 and 3";
      constant SI.Temperature TLIMIT2=1073.15
        "temperature limit between regions 2 and 5";
      constant SI.Temperature TLIMIT5=2273.15 "upper temperature limit of 5";
      constant SI.Pressure PLIMIT1=100.0e6
        "upper pressure limit for regions 1, 2 and 3";
      constant SI.Pressure PLIMIT4A=16.5292e6
        "pressure limit between regions 1 and 2, important for for two-phase (region 4)";
      constant SI.Pressure PLIMIT5=10.0e6
        "upper limit of valid pressure in region 5";
      constant SI.Pressure PCRIT=22064000.0 "the critical pressure";
      constant SI.Temperature TCRIT=647.096 "the critical temperature";
      constant SI.Density DCRIT=322.0 "the critical density";
      constant SI.SpecificEntropy SCRIT=4412.02148223476
        "the calculated specific entropy at the critical point";
      constant SI.SpecificEnthalpy HCRIT=2087546.84511715
        "the calculated specific enthalpy at the critical point";
      constant Real[5] n=array(0.34805185628969e3, -0.11671859879975e1,
          0.10192970039326e-2, 0.57254459862746e3, 0.13918839778870e2)
        "polynomial coefficients for boundary between regions 2 and 3";
      annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
                           <p>Constants needed in the international steam properties IF97.
                           SCRIT and HCRIT are calculated from Helmholtz function for region 3.</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by Hubertus Tummescheit
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</HTML>
"));
    end data;

    function getTstar "get normalization temperature for region 1, 2 or 5"
      extends Modelica.Icons.Function;
      input Integer region "IF 97 region";
      output SI.Temperature Tstar "normalization temperature";
    algorithm
      if region == 1 then
        Tstar
       := data.TSTAR1;
      elseif region == 2 then
        Tstar
       := data.TSTAR2;
      else
        Tstar
       := data.TSTAR5;
      end if;
    end getTstar;

    function getpstar "get normalization pressure for region 1, 2 or 5"
      extends Modelica.Icons.Function;
      input Integer region "IF 97 region";
      output SI.Pressure pstar "normalization pressure";
    algorithm
      if region == 1 then
        pstar
       := data.PSTAR1;
      elseif region == 2 then
        pstar
       := data.PSTAR2;
      else
        pstar
       := data.PSTAR5;
      end if;
    end getpstar;

    record critical "critical point data"
      extends Modelica.Icons.Record;
      constant SI.Pressure PCRIT=22064000.0 "the critical pressure";
      constant SI.Temperature TCRIT=647.096 "the critical temperature";
      constant SI.Density DCRIT=322.0 "the critical density";
      constant SI.SpecificEnthalpy HCRIT=2087546.84511715
        "the calculated specific enthalpy at the critical point";
      constant SI.SpecificEntropy SCRIT=4412.02148223476
        "the calculated specific entropy at the critical point";
      annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
 <p>Critical point data for IF97 steam properties. SCRIT and HCRIT are calculated from helmholtz function for region 3</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</HTML>
"));
    end critical;

    record triple "triple point data"
      extends Modelica.Icons.Record;
      constant SI.Temperature Ttriple=273.16 "the triple point temperature";
      constant SI.Pressure ptriple=611.657 "the triple point temperature";
      constant SI.Density dltriple=999.792520031617642
        "the triple point liquid density";
      constant SI.Density dvtriple=0.485457572477861372e-2
        "the triple point vapour density";
      annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
 <p>Vapour/liquid/ice triple point data for IF97 steam properties.</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</HTML>
"));
    end triple;

    package Regions
      "functions to find the current region for given pairs of input variables"

      extends Modelica.Icons.Package;

      //===================================================================
      //                      "Public" functions

      //===================================================================

      function boundary23ofT
        "boundary function for region boundary between regions 2 and 3 (input temperature)"

        extends Modelica.Icons.Function;
        input SI.Temperature t "temperature (K)";
        output SI.Pressure p "pressure";
      protected
        constant Real[5] n=data.n;
      algorithm
        p := 1.0e6*(n[1] + t*(n[2] + t*n[3]));
      end boundary23ofT;

      function boundary23ofp
        "boundary function for region boundary between regions 2 and 3 (input pressure)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Temperature t "temperature (K)";
      protected
        constant Real[5] n=data.n;
        Real pi "dimensionless pressure";
      algorithm
        pi := p/1.0e6;
        assert(p > triple.ptriple,
          "IF97 medium function boundary23ofp called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        t := n[4] + ((pi - n[5])/n[3])^0.5;
      end boundary23ofp;

      function hlowerofp5
        "explicit lower specific enthalpy limit of region 5 as function of pressure"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real pi "dimensionless pressure";
      algorithm
        pi := p/data.PSTAR5;
        assert(p > triple.ptriple,
          "IF97 medium function hlowerofp5 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        h := 461526.*(9.01505286876203 + pi*(-0.00979043490246092 + (-0.0000203245575263501
           + 3.36540214679088e-7*pi)*pi));
      end hlowerofp5;

      function hupperofp5
        "explicit upper specific enthalpy limit of region 5 as function of pressure"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real pi "dimensionless pressure";
      algorithm
        pi := p/data.PSTAR5;
        assert(p > triple.ptriple,
          "IF97 medium function hupperofp5 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        h := 461526.*(15.9838891400332 + pi*(-0.000489898813722568 + (-5.01510211858761e-8
           + 7.5006972718273e-8*pi)*pi));
      end hupperofp5;

      function slowerofp5
        "explicit lower specific entropy limit of region 5 as function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real pi "dimensionless pressure";
      algorithm
        pi := p/data.PSTAR5;
        assert(p > triple.ptriple,
          "IF97 medium function slowerofp5 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        s := 461.526*(18.4296209980112 + pi*(-0.00730911805860036 + (-0.0000168348072093888
           + 2.09066899426354e-7*pi)*pi) - Modelica.Math.log(pi));
      end slowerofp5;

      function supperofp5
        "explicit upper specific entropy limit of region 5 as function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real pi "dimensionless pressure";
      algorithm
        pi := p/data.PSTAR5;
        assert(p > triple.ptriple,
          "IF97 medium function supperofp5 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        s := 461.526*(22.7281531474243 + pi*(-0.000656650220627603 + (-1.96109739782049e-8
           + 2.19979537113031e-8*pi)*pi) - Modelica.Math.log(pi));
      end supperofp5;

      function hlowerofp1
        "explicit lower specific enthalpy limit of region 1 as function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real pi1 "dimensionless pressure";
        Real[3] o "vector of auxiliary variables";
      algorithm
        pi1 := 7.1 - p/data.PSTAR1;
        assert(p > triple.ptriple,
          "IF97 medium function hlowerofp1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := pi1*pi1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];

        h := 639675.036*(0.173379420894777 + pi1*(-0.022914084306349 + pi1*(-0.00017146768241932
           + pi1*(-4.18695814670391e-6 + pi1*(-2.41630417490008e-7 + pi1*(
          1.73545618580828e-11 + o[1]*pi1*(8.43755552264362e-14 + o[2]*o[3]*pi1
          *(5.35429206228374e-35 + o[1]*(-8.12140581014818e-38 + o[1]*o[2]*(-1.43870236842915e-44
           + pi1*(1.73894459122923e-45 + (-7.06381628462585e-47 +
          9.64504638626269e-49*pi1)*pi1)))))))))));
      end hlowerofp1;

      function hupperofp1
        "explicit upper specific enthalpy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real pi1 "dimensionless pressure";
        Real[3] o "vector of auxiliary variables";
      algorithm
        pi1 := 7.1 - p/data.PSTAR1;
        assert(p > triple.ptriple,
          "IF97 medium function hupperofp1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := pi1*pi1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        h := 639675.036*(2.42896927729349 + pi1*(-0.00141131225285294 + pi1*(
          0.00143759406818289 + pi1*(0.000125338925082983 + pi1*(
          0.0000123617764767172 + pi1*(3.17834967400818e-6 + o[1]*pi1*(
          1.46754947271665e-8 + o[2]*o[3]*pi1*(1.86779322717506e-17 + o[1]*(-4.18568363667416e-19
           + o[1]*o[2]*(-9.19148577641497e-22 + pi1*(4.27026404402408e-22 + (-6.66749357417962e-23
           + 3.49930466305574e-24*pi1)*pi1)))))))))));
      end hupperofp1;

      function slowerofp1
        "explicit lower specific entropy limit of region 1 as function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real pi1 "dimensionless pressure";
        Real[3] o "vector of auxiliary variables";
      algorithm
        pi1 := 7.1 - p/data.PSTAR1;
        assert(p > triple.ptriple,
          "IF97 medium function slowerofp1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := pi1*pi1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        s := 461.526*(-0.0268080988194267 + pi1*(0.00834795890110168 + pi1*(-0.000486470924668433
           + pi1*(-0.0000154902045012264 + pi1*(-1.07631751351358e-6 + pi1*(
          9.64159058957115e-11 + o[1]*pi1*(4.81921078863103e-13 + o[2]*o[3]*pi1
          *(2.7879623870968e-34 + o[1]*(-4.22182957646226e-37 + o[1]*o[2]*(-7.44601427465175e-44
           + pi1*(8.99540001407168e-45 + (-3.65230274480299e-46 +
          4.98464639687285e-48*pi1)*pi1)))))))))));
      end slowerofp1;

      function supperofp1
        "explicit upper specific entropy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real pi1 "dimensionless pressure";
        Real[3] o "vector of auxiliary variables";
      algorithm
        pi1 := 7.1 - p/data.PSTAR1;
        assert(p > triple.ptriple,
          "IF97 medium function supperofp1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := pi1*pi1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        s := 461.526*(7.28316418503422 + pi1*(0.070602197808399 + pi1*(
          0.0039229343647356 + pi1*(0.000313009170788845 + pi1*(
          0.0000303619398631619 + pi1*(7.46739440045781e-6 + o[1]*pi1*(
          3.40562176858676e-8 + o[2]*o[3]*pi1*(4.21886233340801e-17 + o[1]*(-9.44504571473549e-19
           + o[1]*o[2]*(-2.06859611434475e-21 + pi1*(9.60758422254987e-22 + (-1.49967810652241e-22
           + 7.86863124555783e-24*pi1)*pi1)))))))))));
      end supperofp1;

      function hlowerofp2
        "explicit lower specific enthalpy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real pi "dimensionless pressure";
        Real q1 "auxiliary variable";
        Real q2 "auxiliary variable";
        Real[18] o "vector of auxiliary variables";
      algorithm
        pi := p/data.PSTAR2;
        assert(p > triple.ptriple,
          "IF97 medium function hlowerofp2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        q1 := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
        q2 := -0.5 + 540./q1;
        o[1] := q1*q1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := pi*pi;
        o[5] := o[4]*o[4];
        o[6] := q2*q2;
        o[7] := o[6]*o[6];
        o[8] := o[6]*o[7];
        o[9] := o[5]*o[5];
        o[10] := o[7]*o[7];
        o[11] := o[9]*o[9];
        o[12] := o[10]*o[10];
        o[13] := o[12]*o[12];
        o[14] := o[7]*q2;
        o[15] := o[6]*q2;
        o[16] := o[10]*o[6];
        o[17] := o[13]*o[6];
        o[18] := o[13]*o[6]*q2;
        h := (4.63697573303507e9 + 3.74686560065793*o[2] + 3.57966647812489e-6*
          o[1]*o[2] + 2.81881548488163e-13*o[3] - 7.64652332452145e7*q1 -
          0.00450789338787835*o[2]*q1 - 1.55131504410292e-9*o[1]*o[2]*q1 + o[1]
          *(2.51383707870341e6 - 4.78198198764471e6*o[10]*o[11]*o[12]*o[13]*o[4]
           + 49.9651389369988*o[11]*o[12]*o[13]*o[4]*o[5]*o[7] + o[15]*o[4]*(
          1.03746636552761e-13 - 0.00349547959376899*o[16] -
          2.55074501962569e-7*o[8])*o[9] + (-242662.235426958*o[10]*o[12] -
          3.46022402653609*o[16])*o[4]*o[5]*pi + o[4]*(0.109336249381227 -
          2248.08924686956*o[14] - 354742.725841972*o[17] - 24.1331193696374*o[
          6])*pi - 3.09081828396912e-19*o[11]*o[12]*o[5]*o[7]*pi -
          1.24107527851371e-8*o[11]*o[13]*o[4]*o[5]*o[6]*o[7]*pi +
          3.99891272904219*o[5]*o[8]*pi + 0.0641817365250892*o[10]*o[7]*o[9]*pi
           + pi*(-4444.87643334512 - 75253.6156722047*o[14] - 43051.9020511789*
          o[6] - 22926.6247146068*q2) + o[4]*(-8.23252840892034 -
          3927.0508365636*o[15] - 239.325789467604*o[18] - 76407.3727417716*o[8]
           - 94.4508644545118*q2) + 0.360567666582363*o[5]*(-0.0161221195808321
           + q2)*(0.0338039844460968 + q2) + o[11]*(-0.000584580992538624*o[10]
          *o[12]*o[7] + 1.33248030241755e6*o[12]*o[13]*q2) + o[9]*(-7.38502736990986e7
          *o[18] + 0.0000224425477627799*o[6]*o[7]*q2) + o[4]*o[5]*(-2.08438767026518e8
          *o[17] - 0.0000124971648677697*o[6] - 8442.30378348203*o[10]*o[6]*o[7]
          *q2) + o[11]*o[9]*(4.73594929247646e-22*o[10]*o[12]*q2 -
          13.6411358215175*o[10]*o[12]*o[13]*q2 + 5.52427169406836e-10*o[13]*o[
          6]*o[7]*q2) + o[11]*o[5]*(2.67174673301715e-6*o[17] +
          4.44545133805865e-18*o[12]*o[6]*q2 - 50.2465185106411*o[10]*o[13]*o[6]
          *o[7]*q2)))/o[1];
      end hlowerofp2;

      function hupperofp2
        "explicit upper specific enthalpy limit of region 2 as function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real pi "dimensionless pressure";
        Real[2] o "vector of auxiliary variables";
      algorithm
        pi := p/data.PSTAR2;
        assert(p > triple.ptriple,
          "IF97 medium function hupperofp2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := pi*pi;
        o[2] := o[1]*o[1]*o[1];
        h := 4.16066337647071e6 + pi*(-4518.48617188327 + pi*(-8.53409968320258
           + pi*(0.109090430596056 + pi*(-0.000172486052272327 + pi*(
          4.2261295097284e-15 + pi*(-1.27295130636232e-10 + pi*(-3.79407294691742e-25
           + pi*(7.56960433802525e-23 + pi*(7.16825117265975e-32 + pi*(
          3.37267475986401e-21 + (-7.5656940729795e-74 + o[1]*(-8.00969737237617e-134
           + (1.6746290980312e-65 + pi*(-3.71600586812966e-69 + pi*(
          8.06630589170884e-129 + (-1.76117969553159e-103 +
          1.88543121025106e-84*pi)*pi)))*o[1]))*o[2]))))))))));
      end hupperofp2;

      function slowerofp2
        "explicit lower specific entropy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real pi "dimensionless pressure";
        Real q1 "auxiliary variable";
        Real q2 "auxiliary variable";
        Real[40] o "vector of auxiliary variables";
      algorithm
        pi := p/data.PSTAR2;
        assert(p > triple.ptriple,
          "IF97 medium function slowerofp2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        q1 := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
        q2 := -0.5 + 540.0/q1;
        o[1] := pi*pi;
        o[2] := o[1]*pi;
        o[3] := o[1]*o[1];
        o[4] := o[1]*o[3]*pi;
        o[5] := q1*q1;
        o[6] := o[5]*q1;
        o[7] := 1/o[5];
        o[8] := 1/q1;
        o[9] := o[5]*o[5];
        o[10] := o[9]*q1;
        o[11] := q2*q2;
        o[12] := o[11]*q2;
        o[13] := o[1]*o[3];
        o[14] := o[11]*o[11];
        o[15] := o[3]*o[3];
        o[16] := o[1]*o[15];
        o[17] := o[11]*o[14];
        o[18] := o[11]*o[14]*q2;
        o[19] := o[3]*pi;
        o[20] := o[14]*o[14];
        o[21] := o[11]*o[20];
        o[22] := o[15]*pi;
        o[23] := o[14]*o[20]*q2;
        o[24] := o[20]*o[20];
        o[25] := o[15]*o[15];
        o[26] := o[25]*o[3];
        o[27] := o[14]*o[24];
        o[28] := o[25]*o[3]*pi;
        o[29] := o[20]*o[24]*q2;
        o[30] := o[15]*o[25];
        o[31] := o[24]*o[24];
        o[32] := o[11]*o[31]*q2;
        o[33] := o[14]*o[31];
        o[34] := o[1]*o[25]*o[3]*pi;
        o[35] := o[11]*o[14]*o[31]*q2;
        o[36] := o[1]*o[25]*o[3];
        o[37] := o[1]*o[25];
        o[38] := o[20]*o[24]*o[31]*q2;
        o[39] := o[14]*q2;
        o[40] := o[11]*o[31];

        s := 461.526*(9.692768600217 + 1.22151969114703e-16*o[10] +
          0.00018948987516315*o[1]*o[11] + 1.6714766451061e-11*o[12]*o[13] +
          0.0039392777243355*o[1]*o[14] - 1.0406965210174e-19*o[14]*o[16] +
          0.043797295650573*o[1]*o[18] - 2.2922076337661e-6*o[18]*o[19] -
          2.0481737692309e-8*o[2] + 0.00003227767723857*o[12]*o[2] +
          0.0015033924542148*o[17]*o[2] - 1.1256211360459e-11*o[15]*o[20] +
          1.0018179379511e-9*o[11]*o[14]*o[16]*o[20] + 1.0234747095929e-13*o[16]
          *o[21] - 1.9809712802088e-8*o[22]*o[23] + 0.0021171472321355*o[13]*o[
          24] - 8.9185845355421e-25*o[26]*o[27] - 1.2790717852285e-8*o[11]*o[3]
           - 4.8225372718507e-7*o[12]*o[3] - 7.3087610595061e-29*o[11]*o[20]*o[
          24]*o[30] - 0.10693031879409*o[11]*o[24]*o[25]*o[31] +
          4.2002467698208e-6*o[24]*o[26]*o[31] - 5.5414715350778e-17*o[20]*o[30]
          *o[31] + 9.436970724121e-7*o[11]*o[20]*o[24]*o[30]*o[31] +
          23.895741934104*o[13]*o[32] + 0.040668253562649*o[2]*o[32] -
          3.0629316876232e-13*o[26]*o[32] + 0.000026674547914087*o[1]*o[33] +
          8.2311340897998*o[15]*o[33] + 1.2768608934681e-15*o[34]*o[35] +
          0.33662250574171*o[37]*o[38] + 5.905956432427e-18*o[4] +
          0.038946842435739*o[29]*o[4] - 4.88368302964335e-6*o[5] -
          3.34901734177133e6/o[6] + 2.58538448402683e-9*o[6] + 82839.5726841115
          *o[7] - 5446.7940672972*o[8] - 8.40318337484194e-13*o[9] +
          0.0017731742473213*pi + 0.045996013696365*o[11]*pi +
          0.057581259083432*o[12]*pi + 0.05032527872793*o[17]*pi + o[8]*pi*(
          9.63082563787332 - 0.008917431146179*q1) + 0.00811842799898148*q1 +
          0.000033032641670203*o[1]*q2 - 4.3870667284435e-7*o[2]*q2 +
          8.0882908646985e-11*o[14]*o[20]*o[24]*o[25]*q2 + 5.9056029685639e-26*
          o[14]*o[24]*o[28]*q2 + 7.8847309559367e-10*o[3]*q2 -
          3.7826947613457e-6*o[14]*o[24]*o[31]*o[36]*q2 + 1.2621808899101e-6*o[
          11]*o[20]*o[4]*q2 + 540.*o[8]*(10.08665568018 - 0.000033032641670203*
          o[1] - 6.2245802776607e-15*o[10] - 0.015757110897342*o[1]*o[12] -
          5.0144299353183e-11*o[11]*o[13] + 4.1627860840696e-19*o[12]*o[16] -
          0.306581069554011*o[1]*o[17] + 9.0049690883672e-11*o[15]*o[18] +
          0.0000160454534363627*o[17]*o[19] + 4.3870667284435e-7*o[2] -
          0.00009683303171571*o[11]*o[2] + 2.57526266427144e-7*o[14]*o[20]*o[22]
           - 1.40254511313154e-8*o[16]*o[23] - 2.34560435076256e-9*o[14]*o[20]*
          o[24]*o[25] - 1.24017662339842e-24*o[27]*o[28] - 7.8847309559367e-10*
          o[3] + 1.44676118155521e-6*o[11]*o[3] + 1.90027787547159e-27*o[29]*o[
          30] - 0.000960283724907132*o[1]*o[32] - 296.320827232793*o[15]*o[32]
           - 4.97975748452559e-14*o[11]*o[14]*o[31]*o[34] +
          2.21658861403112e-15*o[30]*o[35] + 0.000200482822351322*o[14]*o[24]*o[
          31]*o[36] - 19.1874828272775*o[20]*o[24]*o[31]*o[37] -
          0.0000547344301999018*o[30]*o[38] - 0.0090203547252888*o[2]*o[39] -
          0.0000138839897890111*o[21]*o[4] - 0.973671060893475*o[20]*o[24]*o[4]
           - 836.35096769364*o[13]*o[40] - 1.42338887469272*o[2]*o[40] +
          1.07202609066812e-11*o[26]*o[40] + 0.0000150341259240398*o[5] -
          1.8087714924605e-8*o[6] + 18605.6518987296*o[7] - 306.813232163376*o[
          8] + 1.43632471334824e-11*o[9] + 1.13103675106207e-18*o[5]*o[9] -
          0.017834862292358*pi - 0.172743777250296*o[11]*pi - 0.30195167236758*
          o[39]*pi + o[8]*pi*(-49.6756947920742 + 0.045996013696365*q1) -
          0.0003789797503263*o[1]*q2 - 0.033874355714168*o[11]*o[13]*o[14]*o[20]
          *q2 - 1.0234747095929e-12*o[16]*o[20]*q2 + 1.78371690710842e-23*o[11]
          *o[24]*o[26]*q2 + 2.558143570457e-8*o[3]*q2 + 5.3465159397045*o[24]*o[
          25]*o[31]*q2 - 0.000201611844951398*o[11]*o[14]*o[20]*o[26]*o[31]*q2)
           - Modelica.Math.log(pi));
      end slowerofp2;

      function supperofp2
        "explicit upper specific entropy limit of region 2 as function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real pi "dimensionless pressure";
        Real[2] o "vector of auxiliary variables";
      algorithm
        pi := p/data.PSTAR2;
        assert(p > triple.ptriple,
          "IF97 medium function supperofp2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := pi*pi;
        o[2] := o[1]*o[1]*o[1];
        s := 8505.73409708683 - 461.526*Modelica.Math.log(pi) + pi*(-3.36563543302584
           + pi*(-0.00790283552165338 + pi*(0.0000915558349202221 + pi*(-1.59634706513e-7
           + pi*(3.93449217595397e-18 + pi*(-1.18367426347994e-13 + pi*(
          2.72575244843195e-15 + pi*(7.04803892603536e-26 + pi*(
          6.67637687381772e-35 + pi*(3.1377970315132e-24 + (-7.04844558482265e-77
           + o[1]*(-7.46289531275314e-137 + (1.55998511254305e-68 + pi*(-3.46166288915497e-72
           + pi*(7.51557618628583e-132 + (-1.64086406733212e-106 +
          1.75648443097063e-87*pi)*pi)))*o[1]))*o[2]*o[2]))))))))));
      end supperofp2;

      function d1n "density in region 1 as function of p and T"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.Density d "density";
      protected
        Real pi "dimensionless pressure";
        Real pi1 "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau1 "dimensionless temperature";
        Real gpi "dimensionless Gibbs-derivative w.r.t. pi";
        Real[11] o "auxiliary variables";
      algorithm
        pi := p/data.PSTAR1;
        tau := data.TSTAR1/T;
        pi1 := 7.1 - pi;
        tau1 := tau - 1.222;
        o[1] := tau1*tau1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[1]*o[2];
        o[5] := o[1]*tau1;
        o[6] := o[2]*tau1;
        o[7] := pi1*pi1;
        o[8] := o[7]*o[7];
        o[9] := o[8]*o[8];
        o[10] := o[3]*o[3];
        o[11] := o[10]*o[10];
        gpi := pi1*(pi1*((0.000095038934535162 + o[2]*(8.4812393955936e-6 +
          2.55615384360309e-9*o[4]))/o[2] + pi1*((8.9701127632e-6 + (
          2.60684891582404e-6 + 5.7366919751696e-13*o[2]*o[3])*o[5])/o[6] + pi1
          *(2.02584984300585e-6/o[3] + o[7]*pi1*(o[8]*o[9]*pi1*(o[7]*(o[7]*o[8]
          *(-7.63737668221055e-22/(o[1]*o[11]*o[2]) + pi1*(pi1*(-5.65070932023524e-23
          /(o[11]*o[3]) + (2.99318679335866e-24*pi1)/(o[11]*o[3]*tau1)) +
          3.5842867920213e-22/(o[1]*o[11]*o[2]*tau1))) - 3.33001080055983e-19/(
          o[1]*o[10]*o[2]*o[3]*tau1)) + 1.44400475720615e-17/(o[10]*o[2]*o[3]*
          tau1)) + (1.01874413933128e-8 + 1.39398969845072e-9*o[6])/(o[1]*o[3]*
          tau1))))) + (0.00094368642146534 + o[5]*(0.00060003561586052 + (-0.000095322787813974
           + o[1]*(8.8283690661692e-6 + 1.45389992595188e-15*o[1]*o[2]*o[3]))*
          tau1))/o[5]) + (-0.00028319080123804 + o[1]*(0.00060706301565874 + o[
          4]*(0.018990068218419 + tau1*(0.032529748770505 + (0.021841717175414
           + 0.00005283835796993*o[1])*tau1))))/(o[3]*tau1);
        d := p/(data.RH2O*T*pi*gpi);
      end d1n;

      function d2n "density in region 2  as function of p and T"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.Density d "density";
      protected
        Real pi "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau2 "dimensionless temperature";
        Real gpi "dimensionless Gibbs-derivative w.r.t. pi";
        Real[12] o "auxiliary variables";
      algorithm
        pi := p/data.PSTAR2;
        tau := data.TSTAR2/T;
        tau2 := tau - 0.5;
        o[1] := tau2*tau2;
        o[2] := o[1]*tau2;
        o[3] := o[1]*o[1];
        o[4] := o[3]*o[3];
        o[5] := o[4]*o[4];
        o[6] := o[3]*o[4]*o[5]*tau2;
        o[7] := o[3]*o[4]*tau2;
        o[8] := o[1]*o[3]*o[4];
        o[9] := pi*pi;
        o[10] := o[9]*o[9];
        o[11] := o[3]*o[5]*tau2;
        o[12] := o[5]*o[5];
        gpi := (1. + pi*(-0.0017731742473213 + tau2*(-0.017834862292358 + tau2*
          (-0.045996013696365 + (-0.057581259083432 - 0.05032527872793*o[2])*
          tau2)) + pi*(tau2*(-0.000066065283340406 + (-0.0003789797503263 + o[1]
          *(-0.007878555448671 + o[2]*(-0.087594591301146 -
          0.000053349095828174*o[6])))*tau2) + pi*(6.1445213076927e-8 + (
          1.31612001853305e-6 + o[1]*(-0.00009683303171571 + o[2]*(-0.0045101773626444
           - 0.122004760687947*o[6])))*tau2 + pi*(tau2*(-3.15389238237468e-9 +
          (5.116287140914e-8 + 1.92901490874028e-6*tau2)*tau2) + pi*(
          0.0000114610381688305*o[1]*o[3]*tau2 + pi*(o[2]*(-1.00288598706366e-10
           + o[7]*(-0.012702883392813 - 143.374451604624*o[1]*o[5]*tau2)) + pi*
          (-4.1341695026989e-17 + o[1]*o[4]*(-8.8352662293707e-6 -
          0.272627897050173*o[8])*tau2 + pi*(o[4]*(9.0049690883672e-11 -
          65.8490727183984*o[3]*o[4]*o[5]) + pi*(1.78287415218792e-7*o[7] + pi*
          (o[3]*(1.0406965210174e-18 + o[1]*(-1.0234747095929e-12 -
          1.0018179379511e-8*o[3])*o[3]) + o[10]*o[9]*((-1.29412653835176e-9 +
          1.71088510070544*o[11])*o[6] + o[9]*(-6.05920510335078*o[12]*o[4]*o[5]
          *tau2 + o[9]*(o[3]*o[5]*(1.78371690710842e-23 + o[1]*o[3]*o[4]*(
          6.1258633752464e-12 - 0.000084004935396416*o[7])*tau2) + pi*(-1.24017662339842e-24
          *o[11] + pi*(0.0000832192847496054*o[12]*o[3]*o[5]*tau2 + pi*(o[1]*o[
          4]*o[5]*(1.75410265428146e-27 + (1.32995316841867e-15 -
          0.0000226487297378904*o[1]*o[5])*o[8])*pi - 2.93678005497663e-14*o[1]
          *o[12]*o[3]*tau2)))))))))))))))))/pi;
        d := p/(data.RH2O*T*pi*gpi);
      end d2n;

      function dhot1ofp "density at upper temperature limit of region 1"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Density d "density";
      protected
        Real pi "dimensionless pressure";
        Real pi1 "dimensionless pressure";
        Real[4] o "auxiliary variables";
      algorithm
        pi := p/data.PSTAR1;
        pi1 := 7.1 - pi;
        o[1] := pi1*pi1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*o[3];
        d := 57.4756752485113/(0.0737412153522555 + 0.000102697173772229*o[1]
           + 1.99080616601101e-6*o[2] + 1.35549330686006e-17*o[2]*o[4] -
          3.11228834832975e-19*o[1]*o[2]*o[4] - 7.02987180039442e-22*o[2]*o[3]*
          o[4] - 5.17859076694812e-23*o[1]*o[2]*o[3]*o[4] + 0.00145092247736023
          *pi1 + 0.0000114683182476084*o[1]*pi1 + 1.13217858826367e-8*o[1]*o[2]
          *pi1 + 3.29199117056433e-22*o[2]*o[3]*o[4]*pi1 + 2.73712834080283e-24
          *o[1]*o[2]*o[3]*o[4]*pi1);
      end dhot1ofp;

      function dupper1ofT "density at upper pressure limit of region 1"
        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature (K)";
        output SI.Density d "density";
      protected
        Real tau "dimensionless temperature";
        Real[4] o "auxiliary variables";
      algorithm
        tau := 1386.0/T;
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*o[3];
        d := 57.4756752485113/(2.24144616859917 + 40.9288231166229*o[1] +
          106.47246463213*o[2] + 88.4481480270751*o[1]*o[2] + 31.3207272417546*
          o[3] + 5.47811738891798*o[1]*o[3] + 0.515626225030717*o[2]*o[3] +
          0.0274905057899089*o[1]*o[2]*o[3] + 0.000853742979250503*o[4] +
          0.0000155932210492199*o[1]*o[4] + 1.6621051480279e-7*o[2]*o[4] +
          1.00606771839976e-9*o[1]*o[2]*o[4] + 3.27598951831994e-12*o[3]*o[4]
           + 5.20162317530099e-15*o[1]*o[3]*o[4] + 3.33501889800275e-18*o[2]*o[
          3]*o[4] + 5.50656040141221e-22*o[1]*o[2]*o[3]*o[4] - 13.5354267762204
          *tau - 78.3629702507642*o[1]*tau - 109.374479648652*o[2]*tau -
          57.9035658513312*o[1]*o[2]*tau - 14.215347150565*o[3]*tau -
          1.80906759985501*o[1]*o[3]*tau - 0.127542214693871*o[2]*o[3]*tau -
          0.0051779458313163*o[1]*o[2]*o[3]*tau - 0.000123304142684848*o[4]*tau
           - 1.72405791469972e-6*o[1]*o[4]*tau - 1.39155695911655e-8*o[2]*o[4]*
          tau - 6.23333356847138e-11*o[1]*o[2]*o[4]*tau - 1.44056015732082e-13*
          o[3]*o[4]*tau - 1.50201626932938e-16*o[1]*o[3]*o[4]*tau -
          5.34588682252967e-20*o[2]*o[3]*o[4]*tau - 2.73712834080283e-24*o[1]*o[
          2]*o[3]*o[4]*tau);
      end dupper1ofT;

      function hl_p_R4b
        "explicit approximation of liquid specific enthalpy on the boundary between regions 4 and 3"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real x "auxiliary variable";
      algorithm
          // documentation of accuray in notebook ~hubertus/props/IAPWS/R3Approx.nb
        // boundary between region IVa and III
        x := Modelica.Math.acos(p/data.PCRIT);
        h := (1 + x*(-0.4945586958175176 + x*(1.346800016564904 + x*(-3.889388153209752
           + x*(6.679385472887931 + x*(-6.75820241066552 + x*(3.558919744656498
           + (-0.7179818554978939 - 0.0001152032945617821*x)*x)))))))*data.
          HCRIT;
      end hl_p_R4b;

      function hv_p_R4b
        "explicit approximation of vapour specific enthalpy on the boundary between regions 4 and 3"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real x "auxiliary variable";
      algorithm
        // boundary between region IVa and III
        x := Modelica.Math.acos(p/data.PCRIT);
        h := (1 + x*(0.4880153718655694 + x*(0.2079670746250689 + x*(-6.084122698421623
           + x*(25.08887602293532 + x*(-48.38215180269516 + x*(
          45.66489164833212 + (-16.98555442961553 + 0.0006616936460057691*x)*x)))))))
          *data.HCRIT;
      end hv_p_R4b;

      function sl_p_R4b
        "explicit approximation of liquid specific entropy on the boundary between regions 4 and 3"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real x "auxiliary variable";
      algorithm
        // boundary between region IVa and III
        x := Modelica.Math.acos(p/data.PCRIT);
        s := (1 + x*(-0.36160692245648063 + x*(0.9962778630486647 + x*(-2.8595548144171103
           + x*(4.906301159555333 + x*(-4.974092309614206 + x*(
          2.6249651699204457 + (-0.5319954375299023 - 0.00008064497431880644*x)
          *x)))))))*data.SCRIT;
      end sl_p_R4b;

      function sv_p_R4b
        "explicit approximation of vapour specific entropy on the boundary between regions 4 and 3"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s;
      protected
        Real x "auxiliary variable";
      algorithm

          // documentation of accuray in notebook ~hubertus/props/IAPWS/R3Approx.nb
        // boundary between region IVa and III
        x := Modelica.Math.acos(p/data.PCRIT);
        s := (1 + x*(0.35682641826674344 + x*(0.1642457027815487 + x*(-4.425350377422446
           + x*(18.324477859983133 + x*(-35.338631625948665 + x*(
          33.36181025816282 + (-12.408711490585757 + 0.0004810049834109226*x)*x)))))))
          *data.SCRIT;
      end sv_p_R4b;

      function rhol_p_R4b
        "explicit approximation of liquid density on the boundary between regions 4 and 3"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Density dl "liquid density";
      protected
        Real x "auxiliary variable";
      algorithm
        if (p < data.PCRIT) then
          x := Modelica.Math.acos(p/data.PCRIT);
          dl := (1 + x*(1.903224079094824 + x*(-2.5314861802401123 + x*(-8.191449323843552
             + x*(94.34196116778385 + x*(-369.3676833623383 + x*(
            796.6627910598293 + x*(-994.5385383600702 + x*(673.2581177021598 +
            (-191.43077336405156 + 0.00052536560808895*x)*x)))))))))*data.DCRIT;
        else
          dl := data.DCRIT;
        end if;
      end rhol_p_R4b;

      function rhov_p_R4b
        "explicit approximation of vapour density on the boundary between regions 4 and 2"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Density dv "vapour density";
      protected
        Real x "auxiliary variable";
      algorithm
        if (p < data.PCRIT) then
          x := Modelica.Math.acos(p/data.PCRIT);
          dv := (1 + x*(-1.8463850803362596 + x*(-1.1447872718878493 + x*(
            59.18702203076563 + x*(-403.5391431811611 + x*(1437.2007245332388
             + x*(-3015.853540307519 + x*(3740.5790348670057 + x*(-2537.375817253895
             + (725.8761975803782 - 0.0011151111658332337*x)*x)))))))))*data.
            DCRIT;
        else
          dv := data.DCRIT;
        end if;
      end rhov_p_R4b;

      function boilingcurve_p "properties on the boiling curve"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output Common.IF97PhaseBoundaryProperties bpro "property record";
      protected
        Common.GibbsDerivs g "dimensionless Gibbs funcion and dervatives";
        Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives";
        SI.Pressure plim=min(p, data.PCRIT-1e-7)
          "pressure limited to critical pressure - epsilon";
      algorithm
        bpro.R := data.RH2O;
        bpro.T := Basic.tsat(plim);
        bpro.dpT := Basic.dptofT(bpro.T);
        bpro.region3boundary := bpro.T > data.TLIMIT1;
        if not bpro.region3boundary then
          g := Basic.g1(p, bpro.T);
          bpro.d := p/(bpro.R*bpro.T*g.pi*g.gpi);
          bpro.h := if p > plim then data.HCRIT else bpro.R*bpro.T*g.tau*g.gtau;
          bpro.s := g.R*(g.tau*g.gtau - g.g);
          bpro.cp := -bpro.R*g.tau*g.tau*g.gtautau;
          bpro.vt := bpro.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
          bpro.vp := bpro.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
          bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
          bpro.pd := -bpro.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
        else
          bpro.d := rhol_p_R4b(plim);
          f := Basic.f3(bpro.d, bpro.T);
          bpro.h := hl_p_R4b(plim);
          // bpro.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
          bpro.s := f.R*(f.tau*f.ftau - f.f);
          bpro.cv := bpro.R*(-f.tau*f.tau*f.ftautau);
          bpro.pt := bpro.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
          bpro.pd := bpro.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
        end if;
      end boilingcurve_p;

      function dewcurve_p "properties on the dew curve"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output Common.IF97PhaseBoundaryProperties bpro "property record";
      protected
        Common.GibbsDerivs g "dimensionless Gibbs funcion and dervatives";
        Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives";
        SI.Pressure plim=min(p, data.PCRIT-1e-7)
          "pressure limited to critical pressure - epsilon";
      algorithm
        bpro.R := data.RH2O;
        bpro.T := Basic.tsat(plim);
        bpro.dpT := Basic.dptofT(bpro.T);
        bpro.region3boundary := bpro.T > data.TLIMIT1;
        if not bpro.region3boundary then
          g := Basic.g2(p, bpro.T);
          bpro.d := p/(bpro.R*bpro.T*g.pi*g.gpi);
          bpro.h := if p > plim then data.HCRIT else bpro.R*bpro.T*g.tau*g.gtau;
          bpro.s := g.R*(g.tau*g.gtau - g.g);
          bpro.cp := -bpro.R*g.tau*g.tau*g.gtautau;
          bpro.vt := bpro.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
          bpro.vp := bpro.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
          bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
          bpro.pd := -bpro.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
        else
          bpro.d := rhov_p_R4b(plim);
          f := Basic.f3(bpro.d, bpro.T);
          bpro.h := hv_p_R4b(plim);
          // bpro.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
          bpro.s := f.R*(f.tau*f.ftau - f.f);
          bpro.cv := bpro.R*(-f.tau*f.tau*f.ftautau);
          bpro.pt := bpro.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
          bpro.pd := bpro.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
        end if;
      end dewcurve_p;

      function hvl_p
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input Common.IF97PhaseBoundaryProperties bpro "property record";
        output SI.SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := bpro.h;
        annotation (
          derivative(noDerivative=bpro) = hvl_p_der,
          Inline=false,
          LateInline=true);
      end hvl_p;

      function hl_p
        "liquid specific enthalpy on the boundary between regions 4 and 3 or 1"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := hvl_p(p, boilingcurve_p(p));
      end hl_p;

      function hv_p
        "vapour specific enthalpy on the boundary between regions 4 and 3 or 2"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := hvl_p(p, dewcurve_p(p));
      end hv_p;

      function hvl_p_der
        "derivative function for the specific enthalpy along the phase boundary"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input Common.IF97PhaseBoundaryProperties bpro "property record";
        input Real p_der "derivative of pressure";
        output Real h_der
          "time derivative of specific enthalpy along the phase boundary";
      algorithm
        if bpro.region3boundary then
          h_der := ((bpro.d*bpro.pd - bpro.T*bpro.pt)*p_der + (bpro.T*bpro.pt*
            bpro.pt + bpro.d*bpro.d*bpro.pd*bpro.cv)/bpro.dpT*p_der)/(bpro.pd*
            bpro.d*bpro.d);
        else
          h_der := (1/bpro.d - bpro.T*bpro.vt)*p_der + bpro.cp/bpro.dpT*p_der;
        end if;
      end hvl_p_der;

      function rhovl_p
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input Common.IF97PhaseBoundaryProperties bpro "property record";
        output SI.Density rho "density";
      algorithm
        rho := bpro.d;
        annotation (
          derivative(noDerivative=bpro) = rhovl_p_der,
          Inline=false,
          LateInline=true);
      end rhovl_p;

      function rhol_p "density of saturated water"
        extends Modelica.Icons.Function;
        input SI.Pressure p "saturation pressure";
        output SI.Density rho "density of steam at the condensation point";
      algorithm
        rho := rhovl_p(p, boilingcurve_p(p));
      end rhol_p;

      function rhov_p "density of saturated vapour"
        extends Modelica.Icons.Function;
        input SI.Pressure p "saturation pressure";
        output SI.Density rho "density of steam at the condensation point";
      algorithm
        rho := rhovl_p(p, dewcurve_p(p));
      end rhov_p;

      function rhovl_p_der
        extends Modelica.Icons.Function;
        input SI.Pressure p "saturation pressure";
        input Common.IF97PhaseBoundaryProperties bpro "property record";
        input Real p_der "derivative of pressure";
        output Real d_der "time derivative of density along the phase boundary";
      algorithm
        d_der := if bpro.region3boundary then (p_der - bpro.pt*p_der/bpro.dpT)/
          bpro.pd else -bpro.d*bpro.d*(bpro.vp + bpro.vt/bpro.dpT)*p_der;
      end rhovl_p_der;

      function sl_p
        "liquid specific entropy on the boundary between regions 4 and 3 or 1"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        SI.Temperature Tsat "saturation temperature";
        SI.SpecificEnthalpy h "specific enthalpy";
      algorithm
        if (p < data.PLIMIT4A) then
          Tsat := Basic.tsat(p);
          (h,s) := Isentropic.handsofpT1(p, Tsat);
        elseif (p < data.PCRIT) then
          s := sl_p_R4b(p);
        else
          s := data.SCRIT;
        end if;
      end sl_p;

      function sv_p
        "vapour specific entropy on the boundary between regions 4 and 3 or 2"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.SpecificEntropy s "specific entropy";
      protected
        SI.Temperature Tsat "saturation temperature";
        SI.SpecificEnthalpy h "specific enthalpy";
      algorithm
        if (p < data.PLIMIT4A) then
          Tsat := Basic.tsat(p);
          (h,s) := Isentropic.handsofpT2(p, Tsat);
        elseif (p < data.PCRIT) then
          s := sv_p_R4b(p);
        else
          s := data.SCRIT;
        end if;
      end sv_p;

      function rhol_T "density of saturated water"
        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature";
        output SI.Density d "density of water at the boiling point";
      protected
        SI.Pressure p "saturation pressure";
      algorithm
        p := Basic.psat(T);
        if T < data.TLIMIT1 then
          d := d1n(p, T);
        elseif T < data.TCRIT then
          d := rhol_p_R4b(p);
        else
          d := data.DCRIT;
        end if;
      end rhol_T;

      function rhov_T "density of saturated vapour"
        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature";
        output SI.Density d "density of steam at the condensation point";
      protected
        SI.Pressure p "saturation pressure";
      algorithm

          // assert(T <= data.TCRIT,"input temperature has to be below the critical temperature");
        p := Basic.psat(T);
        if T < data.TLIMIT1 then
          d := d2n(p, T);
        elseif T < data.TCRIT then
          d := rhov_p_R4b(p);
        else
          d := data.DCRIT;
        end if;
      end rhov_T;

      function region_ph
        "return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific enthalpy"
        extends Modelica.Icons.Function;
       input SI.Pressure p "pressure";
       input SI.SpecificEnthalpy h "specific enthalpy";
       input Integer phase=0
          "phase: 2 for two-phase, 1 for one phase, 0 if not known";
       input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
        output Integer region "region (valid values: 1,2,3,4,5) in IF97";
        // If mode is different from 0, no checking for the region is done and
        // the mode is assumed to be the correct region. This can be used to
        // implement e.g., water-only steamtables when mode == 1
      protected
        Boolean hsubcrit;
        SI.Temperature Ttest;
        constant Real[5] n=data.n;
        SI.SpecificEnthalpy hl "bubble enthalpy";
        SI.SpecificEnthalpy hv "dew enthalpy";
      algorithm
        if (mode <> 0) then
          region := mode;
        else
          // check for regions 1, 2, 3 and 4
          hl := hl_p(p);
          hv := hv_p(p);
          if (phase == 2) then
            region := 4;
          else
            // phase == 1 or 0, now check if we are in the legal area
            if
              (p < triple.ptriple) or (p > data.PLIMIT1) or (h < hlowerofp1(p)) or
              ((p < 10.0e6) and (h > hupperofp5(p)))
              or ((p >= 10.0e6) and (h > hupperofp2(p))) then
              // outside of valid range
              region := -1;
            else
              //region 5 and -1 check complete
              hsubcrit := (h < data.HCRIT);
              // simple precheck: very simple if pressure < PLIMIT4A
              if (p < data.PLIMIT4A) then
                // we can never be in region 3, so test for others
                if hsubcrit then
                  if (phase == 1) then
                    region := 1;
                  else
                    if (h < Isentropic.hofpT1(p,Basic.tsat(p))) then
                      region := 1;
                    else
                      region := 4;
                    end if;
                  end if;
                  // external or internal phase check
                else
                  if (h > hlowerofp5(p)) then
                    // check for region 5
                    if ((p < data.PLIMIT5) and (h < hupperofp5(p))) then
                      region := 5;
                    else
                      region := -2;
                      // pressure and specific enthalpy too high, but this should
                    end if;
                    // never happen
                  else
                    if (phase == 1) then
                      region := 2;
                    else
                      if (h > Isentropic.hofpT2(p,Basic.tsat(p))) then
                        region := 2;
                      else
                        region := 4;
                      end if;
                    end if;  // external or internal phase check
                  end if;
                  // tests for region 2 or 5
                end if;
                // tests for sub or supercritical
              else
                // the pressure is over data.PLIMIT4A
                if hsubcrit then
                  // region 1 or 3 or 4
                  if h < hupperofp1(p) then
                    region := 1;
                  else
                    if h < hl  or p > data.PCRIT then
                      region := 3;
                    else
                      region :=4;
                    end if;
                  end if;
                  // enf of test for region 1, 3 or 4
                else
                  // region 2, 3 or 4
                  if (h > hlowerofp2(p)) then
                    region := 2;
                  else
                    if h > hv  or p > data.PCRIT then
                      region := 3;
                    else
                      region := 4;
                    end if;
                  end if;
                  // test for 2 and 3
                end if;
                // tests above PLIMIT4A
              end if;
              // above or below PLIMIT4A
            end if;
            // check for grand limits of p and h
          end if;
          // all tests with phase == 1
        end if;
        // mode was == 0
        // assert(region > 0,"IF97 function called outside the valid range!");
      end region_ph;

      function region_ps
        "return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific entropy"
        extends Modelica.Icons.Function;
       input SI.Pressure p "pressure";
       input SI.SpecificEntropy s "specific entropy";
       input Integer phase=
                      0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
       input Integer mode=
                     0 "mode: 0 means check, otherwise assume region=mode";
        output Integer region "region (valid values: 1,2,3,4,5) in IF97";
        //  If mode is different from 0, no checking for the region is done and
        //    the mode is assumed to be the correct region. This can be used to
        //    implement e.g., water-only steamtables when mode == 1
      protected
        Boolean ssubcrit;
        SI.Temperature Ttest;
        constant Real[5] n=data.n;
        SI.SpecificEntropy sl "bubble entropy";
        SI.SpecificEntropy sv "dew entropy";
      algorithm
        if (mode <> 0) then
          region := mode;
        else
          // check for regions 1, 2, 3, and 4
          sl := sl_p(p);
          sv := sv_p(p);
          // check all cases two-phase
          if (phase == 2) or (phase == 0 and s > sl and s < sv and p < data.PCRIT) then
            region := 4;
          else
            // phase == 1
            region := 0;
            if (p < triple.ptriple) then
              region := -2;
            end if;
            if (p > data.PLIMIT1) then
              region := -3;
            end if;
            if ((p < 10.0e6) and (s > supperofp5(p))) then
              region := -5;
            end if;
            if ((p >= 10.0e6) and (s > supperofp2(p))) then
              region := -6;
            end if;
            if region < 0 then
              assert(false, "region computation from p and s failed: function called outside the legal region");
            else
              ssubcrit := (s < data.SCRIT);
              // simple precheck: very simple if pressure < PLIMIT4A
              if (p < data.PLIMIT4A) then
                // we can never be in region 3, so test for 1 and 2
                if ssubcrit then
                  region := 1;
                else
                  if (s > slowerofp5(p)) then
                    // check for region 5
                    if ((p < data.PLIMIT5) and (s < supperofp5(p))) then
                      region := 5;
                    else
                      region := -1;
                      // pressure and specific entropy too high, should never happen!
                    end if;
                  else
                    region := 2;
                  end if;
                  // tests for region 2 or 5
                end if;
                // tests for sub or supercritical
              else
                // the pressure is over data.PLIMIT4A
                if ssubcrit then
                  // region 1 or 3
                  if s < supperofp1(p) then
                    region := 1;
                  else
                    if s < sl  or p > data.PCRIT then
                      region := 3;
                    else
                      region := 4;
                    end if;
                  end if;
                  // test for region 1, 3 or 4
                else
                  // region 2, 3 or 4
                  if (s > slowerofp2(p)) then
                    region := 2;
                  else
                    if s > sv  or p > data.PCRIT then
                      region := 3;
                    else
                      region := 4;
                    end if;
                  end if;
                  // test for 2,3 and 4
                end if;
                // tests above PLIMIT4A
              end if;
              // above or below PLIMIT4A
            end if;
            // grand test for limits of p and s
          end if;
          // all tests with phase == 1
        end if;
        // mode was == 0
      end region_ps;

      function region_pT
        "return the current region (valid values: 1,2,3,5) in IF97, given pressure and temperature"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        input Integer mode=0
          "mode: 0 means check, otherwise assume region=mode";
        output Integer region
          "region (valid values: 1,2,3,5) in IF97, region 4 is impossible!";
      algorithm
        if (mode <> 0) then
          region := mode;
        else
          if p < data.PLIMIT4A then
            //test for regions 1,2,5
            if T > data.TLIMIT2 then
              region := 5;
            elseif T > Basic.tsat(p) then
              region := 2;
            else
              region := 1;
            end if;
          else
            //test for regions 1,2,3
            if T < data.TLIMIT1 then
              region := 1;
            elseif T < boundary23ofp(p) then
              region := 3;
            else
              region := 2;
            end if;
          end if;
        end if;
        // mode was == 0
      end region_pT;

      function region_dT
        "return the current region (valid values: 1,2,3,4,5) in IF97, given density and temperature"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        input Integer phase= 0
          "phase: 2 for two-phase, 1 for one phase, 0 if not known";
        input Integer mode= 0
          "mode: 0 means check, otherwise assume region=mode";
        output Integer region "(valid values: 1,2,3,4,5) in IF97";
      protected
        Boolean Tovercrit "flag if overcritical temperature";
        SI.Pressure p23 "pressure needed to know if region 2 or 3";
      algorithm
        Tovercrit := T > data.TCRIT;
        if (mode <> 0) then
          region := mode;
        else
          p23 := boundary23ofT(T);
          if T > data.TLIMIT2 then
            if d < 20.5655874106483 then
              // check for the density in the upper corner of validity!
              region := 5;
            else
              assert(false,"out of valid region for IF97, pressure above region 5!");
            end if;
          elseif Tovercrit then
            //check for regions 1, 2 or 3
            if d > d2n(p23, T) and T > data.TLIMIT1 then
              region := 3;
            elseif T < data.TLIMIT1 then
              region := 1;
            else // d  < d2n(p23, T) and T > data.TLIMIT1
              region := 2;
            end if;
            // below critical, check for regions 1, 2, 3 or 4
          elseif (d > rhol_T(T)) then
            // either 1 or 3
            if T < data.TLIMIT1 then
              region := 1;
            else
              region := 3;
            end if;
          elseif (d < rhov_T(T)) then
            // not liquid, not 2-phase, and not region 5, so either 2 or 3 or illegal
            if (d > d2n(p23, T) and T > data.TLIMIT1) then
              region := 3;
            else
              region := 2;
            end if;
          else
            region := 4;
          end if;
        end if;
      end region_dT;

      function hvl_dp
        "derivative function for the specific enthalpy along the phase boundary"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input Common.IF97PhaseBoundaryProperties bpro "property record";
        output Real dh_dp
          "derivative of specific enthalpy along the phase boundary";
      algorithm
        if bpro.region3boundary then
          dh_dp := ((bpro.d*bpro.pd - bpro.T*bpro.pt) + (bpro.T*bpro.pt*
            bpro.pt + bpro.d*bpro.d*bpro.pd*bpro.cv)/bpro.dpT)/(bpro.pd*
            bpro.d*bpro.d);
        else
          dh_dp := (1/bpro.d - bpro.T*bpro.vt) + bpro.cp/bpro.dpT;
        end if;
      end hvl_dp;

      function dhl_dp
        "derivative of liquid specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.DerEnthalpyByPressure dh_dp
          "specific enthalpy derivative w.r.t. pressure";
      algorithm
        dh_dp := hvl_dp(p, boilingcurve_p(p));
      end dhl_dp;

      function dhv_dp
        "derivative of vapour specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.DerEnthalpyByPressure dh_dp
          "specific enthalpy derivative w.r.t. pressure";
      algorithm
        dh_dp := hvl_dp(p, dewcurve_p(p));
      end dhv_dp;

      function drhovl_dp
        extends Modelica.Icons.Function;
        input SI.Pressure p "saturation pressure";
        input Common.IF97PhaseBoundaryProperties bpro "property record";
        output Real dd_dp(unit="kg/(m3.Pa)")
          "derivative of density along the phase boundary";
      algorithm
        dd_dp := if bpro.region3boundary then (1.0 - bpro.pt/bpro.dpT)/
          bpro.pd else -bpro.d*bpro.d*(bpro.vp + bpro.vt/bpro.dpT);
      end drhovl_dp;

      function drhol_dp
        "derivative of density of saturated water w.r.t. pressure"
        extends Modelica.Icons.Function;
        input SI.Pressure p "saturation pressure";
        output SI.DerDensityByPressure dd_dp
          "derivative of density of water at the boiling point";
      algorithm
        dd_dp := drhovl_dp(p, boilingcurve_p(p));
      end drhol_dp;

      function drhov_dp
        "derivative of density of saturated steam w.r.t. pressure"
        extends Modelica.Icons.Function;
        input SI.Pressure p "saturation pressure";
        output SI.DerDensityByPressure dd_dp
          "derivative of density of water at the boiling point";
      algorithm
        dd_dp := drhovl_dp(p, dewcurve_p(p));
      end drhov_dp;
      annotation (Documentation(info="<HTML><h4>Package description</h4>
 <p>Package <b>Regions</b> contains a large number of auxiliary functions which are neede to compute the current region
 of the IAPWS/IF97 for a given pair of input variables as quickly as possible. The focus of this implementation was on
 computational efficiency, not on compact code. Many of the function values calulated in these functions could be obtained
 using the fundamental functions of IAPWS/IF97, but with considerable overhead. If the region of IAPWS/IF97 is known in advance,
 the input variable mode can be set to the region, then the somewhat costly region checks are omitted.
 The checking for the phase has to be done outside the region functions because many properties are not
 differentiable at the region boundary. If the input phase is 2, the output region will be set to 4 immediately.</p>
 <h4>Package contents</h4>
 <p> The main 4 functions in this package are the functions returning the appropriate region for two input variables.
 <ul>
 <li>Function <b>region_ph</b> compute the region of IAPWS/IF97 for input pair pressure and specific enthalpy.</li>
 <li>Function <b>region_ps</b> compute the region of IAPWS/IF97 for input pair pressure and specific entropy</li>
 <li>Function <b>region_dT</b> compute the region of IAPWS/IF97 for input pair density and temperature.</li>
 <li>Function <b>region_pT</b> compute the region of IAPWS/IF97 for input pair pressure and temperature (only ine phase region).</li>
 </ul>
 <p>In addition, functions of the boiling and condensation curves compute the specific enthalpy, specific entropy, or density on these
 curves. The functions for the saturation pressure and temperature are included in the package <b>Basic</b> because they are part of
 the original <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IAPWS/IF97 standards document</a>. These functions are also aliased to
 be used directly from package <b>Water</b>.
</p>
 <ul>
 <li>Function <b>hl_p</b> computes the liquid specific enthalpy as a function of pressure. For overcritical pressures,
 the critical specific enthalpy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>hv_p</b> computes the vapour specific enthalpy as a function of pressure. For overcritical pressures,
 the critical specific enthalpy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>sl_p</b> computes the liquid specific entropy as a function of pressure. For overcritical pressures,
 the critical  specific entropy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>sv_p</b> computes the vapour  specific entropy as a function of pressure. For overcritical pressures,
 the critical  specific entropyis returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>rhol_T</b> computes the liquid density as a function of temperature. For overcritical temperatures,
 the critical density is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>rhol_T</b> computes the vapour density as a function of temperature. For overcritical temperatures,
 the critical density is returned. An approximation is used for temperatures > 623.15 K.</li>
 </ul>
</p>
 <p>All other functions are auxiliary functions called from the region functions to check a specific boundary.</p>
 <ul>
 <li>Function <b>boundary23ofT</b> computes the boundary pressure between regions 2 and 3 (input temperature)</li>
 <li>Function <b>boundary23ofp</b> computes the boundary temperature between regions 2 and 3 (input pressure)</li>
 <li>Function <b>hlowerofp5</b> computes the lower specific enthalpy limit of region 5 (input p, T=1073.15 K)</li>
 <li>Function <b>hupperofp5</b> computes the upper specific enthalpy limit of region 5 (input p, T=2273.15 K)</li>
 <li>Function <b>slowerofp5</b> computes the lower specific entropy limit of region 5 (input p, T=1073.15 K)</li>
 <li>Function <b>supperofp5</b> computes the upper specific entropy limit of region 5 (input p, T=2273.15 K)</li>
 <li>Function <b>hlowerofp1</b> computes the lower specific enthalpy limit of region 1 (input p, T=273.15 K)</li>
 <li>Function <b>hupperofp1</b> computes the upper specific enthalpy limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>slowerofp1</b> computes the lower specific entropy limit of region 1 (input p, T=273.15 K)</li>
 <li>Function <b>supperofp1</b> computes the upper specific entropy limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>hlowerofp2</b> computes the lower specific enthalpy limit of region 2 (input p, T=623.15 K)</li>
 <li>Function <b>hupperofp2</b> computes the upper specific enthalpy limit of region 2 (input p, T=1073.15 K)</li>
 <li>Function <b>slowerofp2</b> computes the lower specific entropy limit of region 2 (input p, T=623.15 K)</li>
 <li>Function <b>supperofp2</b> computes the upper specific entropy limit of region 2 (input p, T=1073.15 K)</li>
 <li>Function <b>d1n</b> computes the density in region 1 as function of pressure and temperature</li>
 <li>Function <b>d2n</b> computes the density in region 2 as function of pressure and temperature</li>
 <li>Function <b>dhot1ofp</b> computes the hot density limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>dupper1ofT</b>computes the high pressure density limit of region 1 (input T, p=100MPa)</li>
 <li>Function <b>hl_p_R4b</b> computes a high accuracy approximation to the liquid enthalpy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>hv_p_R4b</b> computes a high accuracy approximation to the vapour enthalpy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>sl_p_R4b</b> computes a high accuracy approximation to the liquid entropy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>sv_p_R4b</b> computes a high accuracy approximation to the vapour entropy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>rhol_p_R4b</b> computes a high accuracy approximation to the liquid density for temperatures > 623.15 K (input p)</li>
 <li>Function <b>rhov_p_R4b</b> computes a high accuracy approximation to the vapour density for temperatures > 623.15 K (input p)</li>
 </ul>
</p>
<h4>Version Info and Revision history
</h4>
 <ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
<address>Authors: Hubertus Tummescheit, Jonas Eborn and Falko Jens Wagner<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
 <ul>
 <li>Initial version: July 2000</li>
 <li>Revised and extended for inclusion in Modelica.Thermal: December 2002</li>
</ul>
</HTML>
"));
    end Regions;

    //===================================================================
    //                      Base functions

    //===================================================================

    package Basic "Base functions as described in IAWPS/IF97"

      extends Modelica.Icons.Package;

      function g1 "Gibbs function for region 1: g(p,T)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      protected
        Real pi1 "dimensionless pressure";
        Real tau1 "dimensionless temperature";
        Real[45] o "vector of auxiliary variables";
        Real pl "auxiliary variable";
      algorithm
        pl := min(p, data.PCRIT - 1);
        assert(p > triple.ptriple,
          "IF97 medium function g1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= 100.0e6,
          "IF97 medium function g1: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
        assert(T >= 273.15,
          "IF97 medium function g1: the temperature (= " + String(T) + " K)  is lower than 273.15 K!");
        g.p := p;
        g.T := T;
        g.R := data.RH2O;
        g.pi := p/data.PSTAR1;
        g.tau := data.TSTAR1/T;
        pi1 := 7.1000000000000 - g.pi;
        tau1 := -1.22200000000000 + g.tau;
        o[1] := tau1*tau1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*tau1;
        o[5] := 1/o[4];
        o[6] := o[1]*o[2];
        o[7] := o[1]*tau1;
        o[8] := 1/o[7];
        o[9] := o[1]*o[2]*o[3];
        o[10] := 1/o[2];
        o[11] := o[2]*tau1;
        o[12] := 1/o[11];
        o[13] := o[2]*o[3];
        o[14] := 1/o[3];
        o[15] := pi1*pi1;
        o[16] := o[15]*pi1;
        o[17] := o[15]*o[15];
        o[18] := o[17]*o[17];
        o[19] := o[17]*o[18]*pi1;
        o[20] := o[15]*o[17];
        o[21] := o[3]*o[3];
        o[22] := o[21]*o[21];
        o[23] := o[22]*o[3]*tau1;
        o[24] := 1/o[23];
        o[25] := o[22]*o[3];
        o[26] := 1/o[25];
        o[27] := o[1]*o[2]*o[22]*tau1;
        o[28] := 1/o[27];
        o[29] := o[1]*o[2]*o[22];
        o[30] := 1/o[29];
        o[31] := o[1]*o[2]*o[21]*o[3]*tau1;
        o[32] := 1/o[31];
        o[33] := o[2]*o[21]*o[3]*tau1;
        o[34] := 1/o[33];
        o[35] := o[1]*o[3]*tau1;
        o[36] := 1/o[35];
        o[37] := o[1]*o[3];
        o[38] := 1/o[37];
        o[39] := 1/o[6];
        o[40] := o[1]*o[22]*o[3];
        o[41] := 1/o[40];
        o[42] := 1/o[22];
        o[43] := o[1]*o[2]*o[21]*o[3];
        o[44] := 1/o[43];
        o[45] := 1/o[13];
        g.g := pi1*(pi1*(pi1*(o[10]*(-0.000031679644845054 + o[2]*(-2.82707979853120e-6
           - 8.5205128120103e-10*o[6])) + pi1*(o[12]*(-2.24252819080000e-6 + (-6.5171222895601e-7
           - 1.43417299379240e-13*o[13])*o[7]) + pi1*(-4.0516996860117e-7*o[14]
           + o[16]*((-1.27343017416410e-9 - 1.74248712306340e-10*o[11])*o[36]
           + o[19]*(-6.8762131295531e-19*o[34] + o[15]*(1.44783078285210e-20*o[
          32] + o[20]*(2.63357816627950e-23*o[30] + pi1*(-1.19476226400710e-23*
          o[28] + pi1*(1.82280945814040e-24*o[26] - 9.3537087292458e-26*o[24]*
          pi1))))))))) + o[8]*(-0.00047184321073267 + o[7]*(-0.000300017807930260
           + (0.000047661393906987 + o[1]*(-4.4141845330846e-6 -
          7.2694996297594e-16*o[9]))*tau1))) + o[5]*(0.000283190801238040 + o[1]
          *(-0.00060706301565874 + o[6]*(-0.0189900682184190 + tau1*(-0.032529748770505
           + (-0.0218417171754140 - 0.000052838357969930*o[1])*tau1))))) + (
          0.146329712131670 + tau1*(-0.84548187169114 + tau1*(-3.7563603672040
           + tau1*(3.3855169168385 + tau1*(-0.95791963387872 + tau1*(
          0.157720385132280 + (-0.0166164171995010 + 0.00081214629983568*tau1)*
          tau1))))))/o[1];

        g.gpi := pi1*(pi1*(o[10]*(0.000095038934535162 + o[2]*(
          8.4812393955936e-6 + 2.55615384360309e-9*o[6])) + pi1*(o[12]*(
          8.9701127632000e-6 + (2.60684891582404e-6 + 5.7366919751696e-13*o[13])
          *o[7]) + pi1*(2.02584984300585e-6*o[14] + o[16]*((1.01874413933128e-8
           + 1.39398969845072e-9*o[11])*o[36] + o[19]*(1.44400475720615e-17*o[
          34] + o[15]*(-3.3300108005598e-19*o[32] + o[20]*(-7.6373766822106e-22
          *o[30] + pi1*(3.5842867920213e-22*o[28] + pi1*(-5.6507093202352e-23*o[
          26] + 2.99318679335866e-24*o[24]*pi1))))))))) + o[8]*(
          0.00094368642146534 + o[7]*(0.00060003561586052 + (-0.000095322787813974
           + o[1]*(8.8283690661692e-6 + 1.45389992595188e-15*o[9]))*tau1))) + o[
          5]*(-0.000283190801238040 + o[1]*(0.00060706301565874 + o[6]*(
          0.0189900682184190 + tau1*(0.032529748770505 + (0.0218417171754140 +
          0.000052838357969930*o[1])*tau1))));

        g.gpipi := pi1*(o[10]*(-0.000190077869070324 + o[2]*(-0.0000169624787911872
           - 5.1123076872062e-9*o[6])) + pi1*(o[12]*(-0.0000269103382896000 + (
          -7.8205467474721e-6 - 1.72100759255088e-12*o[13])*o[7]) + pi1*(-8.1033993720234e-6
          *o[14] + o[16]*((-7.1312089753190e-8 - 9.7579278891550e-9*o[11])*o[36]
           + o[19]*(-2.88800951441230e-16*o[34] + o[15]*(7.3260237612316e-18*o[
          32] + o[20]*(2.13846547101895e-20*o[30] + pi1*(-1.03944316968618e-20*
          o[28] + pi1*(1.69521279607057e-21*o[26] - 9.2788790594118e-23*o[24]*
          pi1))))))))) + o[8]*(-0.00094368642146534 + o[7]*(-0.00060003561586052
           + (0.000095322787813974 + o[1]*(-8.8283690661692e-6 -
          1.45389992595188e-15*o[9]))*tau1));

        g.gtau := pi1*(o[38]*(-0.00254871721114236 + o[1]*(0.0042494411096112
           + (0.0189900682184190 + (-0.0218417171754140 - 0.000158515073909790*
          o[1])*o[1])*o[6])) + pi1*(o[10]*(0.00141552963219801 + o[2]*(
          0.000047661393906987 + o[1]*(-0.0000132425535992538 -
          1.23581493705910e-14*o[9]))) + pi1*(o[12]*(0.000126718579380216 -
          5.1123076872062e-9*o[37]) + pi1*(o[39]*(0.0000112126409540000 + (
          1.30342445791202e-6 - 1.43417299379240e-12*o[13])*o[7]) + pi1*(
          3.2413597488094e-6*o[5] + o[16]*((1.40077319158051e-8 +
          1.04549227383804e-9*o[11])*o[45] + o[19]*(1.99410180757040e-17*o[44]
           + o[15]*(-4.4882754268415e-19*o[42] + o[20]*(-1.00075970318621e-21*o[
          28] + pi1*(4.6595728296277e-22*o[26] + pi1*(-7.2912378325616e-23*o[24]
           + 3.8350205789908e-24*o[41]*pi1))))))))))) + o[8]*(-0.292659424263340
           + tau1*(0.84548187169114 + o[1]*(3.3855169168385 + tau1*(-1.91583926775744
           + tau1*(0.47316115539684 + (-0.066465668798004 + 0.0040607314991784*
          tau1)*tau1)))));

        g.gtautau := pi1*(o[36]*(0.0254871721114236 + o[1]*(-0.033995528876889
           + (-0.037980136436838 - 0.00031703014781958*o[2])*o[6])) + pi1*(o[12]
          *(-0.0056621185287920 + o[6]*(-0.0000264851071985076 -
          1.97730389929456e-13*o[9])) + pi1*((-0.00063359289690108 -
          2.55615384360309e-8*o[37])*o[39] + pi1*(pi1*(-0.0000291722377392842*o[
          38] + o[16]*(o[19]*(-5.9823054227112e-16*o[32] + o[15]*(o[20]*(
          3.9029628424262e-20*o[26] + pi1*(-1.86382913185108e-20*o[24] + pi1*(
          2.98940751135026e-21*o[41] - (1.61070864317613e-22*pi1)/(o[1]*o[22]*o[
          3]*tau1)))) + 1.43624813658928e-17/(o[22]*tau1))) + (-1.68092782989661e-7
           - 7.3184459168663e-9*o[11])/(o[2]*o[3]*tau1))) + (-0.000067275845724000
           + (-3.9102733737361e-6 - 1.29075569441316e-11*o[13])*o[7])/(o[1]*o[2]
          *tau1))))) + o[10]*(0.87797827279002 + tau1*(-1.69096374338228 + o[7]
          *(-1.91583926775744 + tau1*(0.94632231079368 + (-0.199397006394012 +
          0.0162429259967136*tau1)*tau1))));

        g.gtaupi := o[38]*(0.00254871721114236 + o[1]*(-0.0042494411096112 + (-0.0189900682184190
           + (0.0218417171754140 + 0.000158515073909790*o[1])*o[1])*o[6])) +
          pi1*(o[10]*(-0.00283105926439602 + o[2]*(-0.000095322787813974 + o[1]
          *(0.0000264851071985076 + 2.47162987411820e-14*o[9]))) + pi1*(o[12]*(
          -0.00038015573814065 + 1.53369230616185e-8*o[37]) + pi1*(o[39]*(-0.000044850563816000
           + (-5.2136978316481e-6 + 5.7366919751696e-12*o[13])*o[7]) + pi1*(-0.0000162067987440468
          *o[5] + o[16]*((-1.12061855326441e-7 - 8.3639381907043e-9*o[11])*o[45]
           + o[19]*(-4.1876137958978e-16*o[44] + o[15]*(1.03230334817355e-17*o[
          42] + o[20]*(2.90220313924001e-20*o[28] + pi1*(-1.39787184888831e-20*
          o[26] + pi1*(2.26028372809410e-21*o[24] - 1.22720658527705e-22*o[41]*
          pi1))))))))));
      end g1;

      function g2 "Gibbs function for region 2: g(p,T)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      protected
        Real tau2 "dimensionless temperature";
        Real[55] o "vector of auxiliary variables";
      algorithm
        g.p := p;
        g.T := T;
        g.R := data.RH2O;
        assert(p > triple.ptriple,
          "IF97 medium function g2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= 100.0e6,
          "IF97 medium function g2: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
        assert(T >= 273.15,
          "IF97 medium function g2: the temperature (= " + String(T) + " K) is lower than 273.15 K!");
        assert(T <= 1073.15,
          "IF97 medium function g2: the input temperature (= " + String(T) + " K) is higher than the limit of 1073.15 K");
        g.pi := p/data.PSTAR2;
        g.tau := data.TSTAR2/T;
        tau2 := -0.5 + g.tau;
        o[1] := tau2*tau2;
        o[2] := o[1]*tau2;
        o[3] := -0.050325278727930*o[2];
        o[4] := -0.057581259083432 + o[3];
        o[5] := o[4]*tau2;
        o[6] := -0.045996013696365 + o[5];
        o[7] := o[6]*tau2;
        o[8] := -0.0178348622923580 + o[7];
        o[9] := o[8]*tau2;
        o[10] := o[1]*o[1];
        o[11] := o[10]*o[10];
        o[12] := o[11]*o[11];
        o[13] := o[10]*o[11]*o[12]*tau2;
        o[14] := o[1]*o[10]*tau2;
        o[15] := o[10]*o[11]*tau2;
        o[16] := o[1]*o[12]*tau2;
        o[17] := o[1]*o[11]*tau2;
        o[18] := o[1]*o[10]*o[11];
        o[19] := o[10]*o[11]*o[12];
        o[20] := o[1]*o[10];
        o[21] := g.pi*g.pi;
        o[22] := o[21]*o[21];
        o[23] := o[21]*o[22];
        o[24] := o[10]*o[12]*tau2;
        o[25] := o[12]*o[12];
        o[26] := o[11]*o[12]*o[25]*tau2;
        o[27] := o[10]*o[12];
        o[28] := o[1]*o[10]*o[11]*tau2;
        o[29] := o[10]*o[12]*o[25]*tau2;
        o[30] := o[1]*o[10]*o[25]*tau2;
        o[31] := o[1]*o[11]*o[12];
        o[32] := o[1]*o[12];
        o[33] := g.tau*g.tau;
        o[34] := o[33]*o[33];
        o[35] := -0.000053349095828174*o[13];
        o[36] := -0.087594591301146 + o[35];
        o[37] := o[2]*o[36];
        o[38] := -0.0078785554486710 + o[37];
        o[39] := o[1]*o[38];
        o[40] := -0.00037897975032630 + o[39];
        o[41] := o[40]*tau2;
        o[42] := -0.000066065283340406 + o[41];
        o[43] := o[42]*tau2;
        o[44] := 5.7870447262208e-6*tau2;
        o[45] := -0.301951672367580*o[2];
        o[46] := -0.172743777250296 + o[45];
        o[47] := o[46]*tau2;
        o[48] := -0.091992027392730 + o[47];
        o[49] := o[48]*tau2;
        o[50] := o[1]*o[11];
        o[51] := o[10]*o[11];
        o[52] := o[11]*o[12]*o[25];
        o[53] := o[10]*o[12]*o[25];
        o[54] := o[1]*o[10]*o[25];
        o[55] := o[11]*o[12]*tau2;

        g.g := g.pi*(-0.00177317424732130 + o[9] + g.pi*(tau2*(-0.000033032641670203
           + (-0.000189489875163150 + o[1]*(-0.0039392777243355 + (-0.043797295650573
           - 0.0000266745479140870*o[13])*o[2]))*tau2) + g.pi*(
          2.04817376923090e-8 + (4.3870667284435e-7 + o[1]*(-0.000032277677238570
           + (-0.00150339245421480 - 0.040668253562649*o[13])*o[2]))*tau2 + g.
          pi*(g.pi*(2.29220763376610e-6*o[14] + g.pi*((-1.67147664510610e-11 +
          o[15]*(-0.00211714723213550 - 23.8957419341040*o[16]))*o[2] + g.pi*(-5.9059564324270e-18
           + o[17]*(-1.26218088991010e-6 - 0.038946842435739*o[18]) + g.pi*(o[
          11]*(1.12562113604590e-11 - 8.2311340897998*o[19]) + g.pi*(
          1.98097128020880e-8*o[15] + g.pi*(o[10]*(1.04069652101740e-19 + (-1.02347470959290e-13
           - 1.00181793795110e-9*o[10])*o[20]) + o[23]*(o[13]*(-8.0882908646985e-11
           + 0.106930318794090*o[24]) + o[21]*(-0.33662250574171*o[26] + o[21]*
          (o[27]*(8.9185845355421e-25 + (3.06293168762320e-13 -
          4.2002467698208e-6*o[15])*o[28]) + g.pi*(-5.9056029685639e-26*o[24]
           + g.pi*(3.7826947613457e-6*o[29] + g.pi*(-1.27686089346810e-15*o[30]
           + o[31]*(7.3087610595061e-29 + o[18]*(5.5414715350778e-17 -
          9.4369707241210e-7*o[32]))*g.pi)))))))))))) + tau2*(-7.8847309559367e-10
           + (1.27907178522850e-8 + 4.8225372718507e-7*tau2)*tau2))))) + (-0.0056087911830200
           + g.tau*(0.071452738814550 + g.tau*(-0.40710498239280 + g.tau*(
          1.42408197144400 + g.tau*(-4.3839511194500 + g.tau*(-9.6927686002170
           + g.tau*(10.0866556801800 + (-0.284086326077200 + 0.0212684635330700
          *g.tau)*g.tau) + Modelica.Math.log(g.pi)))))))/(o[34]*g.tau);

        g.gpi := (1.00000000000000 + g.pi*(-0.00177317424732130 + o[9] + g.pi*(
          o[43] + g.pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[1]*(-0.000096833031715710
           + (-0.0045101773626444 - 0.122004760687947*o[13])*o[2]))*tau2 + g.pi
          *(g.pi*(0.0000114610381688305*o[14] + g.pi*((-1.00288598706366e-10 +
          o[15]*(-0.0127028833928130 - 143.374451604624*o[16]))*o[2] + g.pi*(-4.1341695026989e-17
           + o[17]*(-8.8352662293707e-6 - 0.272627897050173*o[18]) + g.pi*(o[11]
          *(9.0049690883672e-11 - 65.849072718398*o[19]) + g.pi*(
          1.78287415218792e-7*o[15] + g.pi*(o[10]*(1.04069652101740e-18 + (-1.02347470959290e-12
           - 1.00181793795110e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.29412653835176e-9
           + 1.71088510070544*o[24]) + o[21]*(-6.0592051033508*o[26] + o[21]*(o[
          27]*(1.78371690710842e-23 + (6.1258633752464e-12 -
          0.000084004935396416*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[24]
           + g.pi*(0.000083219284749605*o[29] + g.pi*(-2.93678005497663e-14*o[
          30] + o[31]*(1.75410265428146e-27 + o[18]*(1.32995316841867e-15 -
          0.0000226487297378904*o[32]))*g.pi)))))))))))) + tau2*(-3.15389238237468e-9
           + (5.1162871409140e-8 + 1.92901490874028e-6*tau2)*tau2))))))/g.pi;

        g.gpipi := (-1.00000000000000 + o[21]*(o[43] + g.pi*(
          1.22890426153854e-7 + (2.63224003706610e-6 + o[1]*(-0.000193666063431420
           + (-0.0090203547252888 - 0.244009521375894*o[13])*o[2]))*tau2 + g.pi
          *(g.pi*(0.000045844152675322*o[14] + g.pi*((-5.0144299353183e-10 + o[
          15]*(-0.063514416964065 - 716.87225802312*o[16]))*o[2] + g.pi*(-2.48050170161934e-16
           + o[17]*(-0.000053011597376224 - 1.63576738230104*o[18]) + g.pi*(o[
          11]*(6.3034783618570e-10 - 460.94350902879*o[19]) + g.pi*(
          1.42629932175034e-6*o[15] + g.pi*(o[10]*(9.3662686891566e-18 + (-9.2112723863361e-12
           - 9.0163614415599e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.94118980752764e-8
           + 25.6632765105816*o[24]) + o[21]*(-103.006486756963*o[26] + o[21]*(
          o[27]*(3.3890621235060e-22 + (1.16391404129682e-10 -
          0.00159609377253190*o[15])*o[28]) + g.pi*(-2.48035324679684e-23*o[24]
           + g.pi*(0.00174760497974171*o[29] + g.pi*(-6.4609161209486e-13*o[30]
           + o[31]*(4.0344361048474e-26 + o[18]*(3.05889228736295e-14 -
          0.00052092078397148*o[32]))*g.pi)))))))))))) + tau2*(-9.4616771471240e-9
           + (1.53488614227420e-7 + o[44])*tau2)))))/o[21];

        g.gtau := (0.0280439559151000 + g.tau*(-0.285810955258200 + g.tau*(
          1.22131494717840 + g.tau*(-2.84816394288800 + g.tau*(4.3839511194500
           + o[33]*(10.0866556801800 + (-0.56817265215440 + 0.063805390599210*g.
           tau)*g.tau))))))/(o[33]*o[34]) + g.pi*(-0.0178348622923580 + o[49]
           + g.pi*(-0.000033032641670203 + (-0.00037897975032630 + o[1]*(-0.0157571108973420
           + (-0.306581069554011 - 0.00096028372490713*o[13])*o[2]))*tau2 + g.
          pi*(4.3870667284435e-7 + o[1]*(-0.000096833031715710 + (-0.0090203547252888
           - 1.42338887469272*o[13])*o[2]) + g.pi*(-7.8847309559367e-10 + g.pi*
          (0.0000160454534363627*o[20] + g.pi*(o[1]*(-5.0144299353183e-11 + o[
          15]*(-0.033874355714168 - 836.35096769364*o[16])) + g.pi*((-0.0000138839897890111
           - 0.97367106089347*o[18])*o[50] + g.pi*(o[14]*(9.0049690883672e-11
           - 296.320827232793*o[19]) + g.pi*(2.57526266427144e-7*o[51] + g.pi*(
          o[2]*(4.1627860840696e-19 + (-1.02347470959290e-12 -
          1.40254511313154e-8*o[10])*o[20]) + o[23]*(o[19]*(-2.34560435076256e-9
           + 5.3465159397045*o[24]) + o[21]*(-19.1874828272775*o[52] + o[21]*(o[
          16]*(1.78371690710842e-23 + (1.07202609066812e-11 -
          0.000201611844951398*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[27]
           + g.pi*(0.000200482822351322*o[53] + g.pi*(-4.9797574845256e-14*o[54]
           + (1.90027787547159e-27 + o[18]*(2.21658861403112e-15 -
          0.000054734430199902*o[32]))*o[55]*g.pi)))))))))))) + (
          2.55814357045700e-8 + 1.44676118155521e-6*tau2)*tau2))));

        g.gtautau := (-0.168263735490600 + g.tau*(1.42905477629100 + g.tau*(-4.8852597887136
           + g.tau*(8.5444918286640 + g.tau*(-8.7679022389000 + o[33]*(-0.56817265215440
           + 0.127610781198420*g.tau)*g.tau)))))/(o[33]*o[34]*g.tau) + g.pi*(-0.091992027392730
           + (-0.34548755450059 - 1.50975836183790*o[2])*tau2 + g.pi*(-0.00037897975032630
           + o[1]*(-0.047271332692026 + (-1.83948641732407 - 0.033609930371750*
          o[13])*o[2]) + g.pi*((-0.000193666063431420 + (-0.045101773626444 -
          48.395221739552*o[13])*o[2])*tau2 + g.pi*(2.55814357045700e-8 +
          2.89352236311042e-6*tau2 + g.pi*(0.000096272720618176*o[10]*tau2 + g.
          pi*((-1.00288598706366e-10 + o[15]*(-0.50811533571252 -
          28435.9329015838*o[16]))*tau2 + g.pi*(o[11]*(-0.000138839897890111 -
          23.3681054614434*o[18])*tau2 + g.pi*((6.3034783618570e-10 -
          10371.2289531477*o[19])*o[20] + g.pi*(3.09031519712573e-6*o[17] + g.
          pi*(o[1]*(1.24883582522088e-18 + (-9.2112723863361e-12 -
          1.82330864707100e-7*o[10])*o[20]) + o[23]*(o[1]*o[11]*o[12]*(-6.5676921821352e-8
           + 261.979281045521*o[24])*tau2 + o[21]*(-1074.49903832754*o[1]*o[10]
          *o[12]*o[25]*tau2 + o[21]*((3.3890621235060e-22 + (
          3.6448887082716e-10 - 0.0094757567127157*o[15])*o[28])*o[32] + g.pi*(
          -2.48035324679684e-23*o[16] + g.pi*(0.0104251067622687*o[1]*o[12]*o[
          25]*tau2 + g.pi*(o[11]*o[12]*(4.7506946886790e-26 + o[18]*(
          8.6446955947214e-14 - 0.00311986252139440*o[32]))*g.pi -
          1.89230784411972e-12*o[10]*o[25]*tau2))))))))))))))));

        g.gtaupi := -0.0178348622923580 + o[49] + g.pi*(-0.000066065283340406
           + (-0.00075795950065260 + o[1]*(-0.0315142217946840 + (-0.61316213910802
           - 0.00192056744981426*o[13])*o[2]))*tau2 + g.pi*(1.31612001853305e-6
           + o[1]*(-0.000290499095147130 + (-0.0270610641758664 -
          4.2701666240781*o[13])*o[2]) + g.pi*(-3.15389238237468e-9 + g.pi*(
          0.000080227267181813*o[20] + g.pi*(o[1]*(-3.00865796119098e-10 + o[15]
          *(-0.203246134285008 - 5018.1058061618*o[16])) + g.pi*((-0.000097187928523078
           - 6.8156974262543*o[18])*o[50] + g.pi*(o[14]*(7.2039752706938e-10 -
          2370.56661786234*o[19]) + g.pi*(2.31773639784430e-6*o[51] + g.pi*(o[2]
          *(4.1627860840696e-18 + (-1.02347470959290e-11 - 1.40254511313154e-7*
          o[10])*o[20]) + o[23]*(o[19]*(-3.7529669612201e-8 + 85.544255035272*o[
          24]) + o[21]*(-345.37469089099*o[52] + o[21]*(o[16]*(
          3.5674338142168e-22 + (2.14405218133624e-10 - 0.0040322368990280*o[15])
          *o[28]) + g.pi*(-2.60437090913668e-23*o[27] + g.pi*(
          0.0044106220917291*o[53] + g.pi*(-1.14534422144089e-12*o[54] + (
          4.5606669011318e-26 + o[18]*(5.3198126736747e-14 -
          0.00131362632479764*o[32]))*o[55]*g.pi)))))))))))) + (
          1.02325742818280e-7 + o[44])*tau2)));
      end g2;

      function g2metastable
        "Gibbs function for metastable part of region 2: g(p,T)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      protected
        Real pi "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau2 "dimensionless temperature";
        Real[27] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function g2metastable called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= 100.0e6,
          "IF97 medium function g2metastable: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
        assert(T >= 273.15,
          "IF97 medium function g2metastable: the temperature (= " + String(T) + " K) is lower than 273.15 K!");
        assert(T <= 1073.15,
          "IF97 medium function g2metastable: the input temperature (= " + String(T) + " K) is higher than the limit of 1073.15 K");
        g.p := p;
        g.T := T;
        g.R := data.RH2O;
        g.pi := p/data.PSTAR2;
        g.tau := data.TSTAR2/T;
        tau2 := -0.5 + g.tau;
        o[1] := tau2*tau2;
        o[2] := o[1]*tau2;
        o[3] := o[1]*o[1];
        o[4] := o[1]*o[3];
        o[5] := -0.0040813178534455*o[4];
        o[6] := -0.072334555213245 + o[5];
        o[7] := o[2]*o[6];
        o[8] := -0.088223831943146 + o[7];
        o[9] := o[1]*o[8];
        o[10] := o[3]*o[3];
        o[11] := o[10]*tau2;
        o[12] := o[10]*o[3];
        o[13] := o[1]*o[3]*tau2;
        o[14] := g.tau*g.tau;
        o[15] := o[14]*o[14];
        o[16] := -0.015238081817394*o[11];
        o[17] := -0.106091843797284 + o[16];
        o[18] := o[17]*o[4];
        o[19] := 0.0040195606760414 + o[18];
        o[20] := o[19]*tau2;
        o[21] := g.pi*g.pi;
        o[22] := -0.0448944963879005*o[4];
        o[23] := -0.361672776066225 + o[22];
        o[24] := o[2]*o[23];
        o[25] := -0.176447663886292 + o[24];
        o[26] := o[25]*tau2;
        o[27] := o[3]*tau2;

        g.g := g.pi*(-0.0073362260186506 + o[9] + g.pi*(g.pi*((-0.0063498037657313
           - 0.086043093028588*o[12])*o[3] + g.pi*(o[13]*(0.007532158152277 -
          0.0079238375446139*o[2]) + o[11]*g.pi*(-0.00022888160778447 -
          0.002645650148281*tau2))) + (0.0020097803380207 + (-0.053045921898642
           - 0.007619040908697*o[11])*o[4])*tau2)) + (-0.00560879118302 + g.tau
          *(0.07145273881455 + g.tau*(-0.4071049823928 + g.tau*(1.424081971444
           + g.tau*(-4.38395111945 + g.tau*(-9.6937268393049 + g.tau*(
          10.087275970006 + (-0.2840863260772 + 0.02126846353307*g.tau)*g.tau)
           + Modelica.Math.log(g.pi)))))))/(o[15]*g.tau);

        g.gpi := (1.0 + g.pi*(-0.0073362260186506 + o[9] + g.pi*(o[20] + g.pi*(
          (-0.0190494112971939 - 0.258129279085764*o[12])*o[3] + g.pi*(o[13]*(
          0.030128632609108 - 0.0316953501784556*o[2]) + o[11]*g.pi*(-0.00114440803892235
           - 0.013228250741405*tau2))))))/g.pi;

        g.gpipi := (-1. + o[21]*(o[20] + g.pi*((-0.0380988225943878 -
          0.516258558171528*o[12])*o[3] + g.pi*(o[13]*(0.090385897827324 -
          0.0950860505353668*o[2]) + o[11]*g.pi*(-0.0045776321556894 -
          0.05291300296562*tau2)))))/o[21];

        g.gtau := (0.0280439559151 + g.tau*(-0.2858109552582 + g.tau*(
          1.2213149471784 + g.tau*(-2.848163942888 + g.tau*(4.38395111945 + o[
          14]*(10.087275970006 + (-0.5681726521544 + 0.06380539059921*g.tau)*g.
          tau))))))/(o[14]*o[15]) + g.pi*(o[26] + g.pi*(0.0020097803380207 + (-0.371321453290494
           - 0.121904654539152*o[11])*o[4] + g.pi*((-0.0253992150629252 -
          1.37668948845741*o[12])*o[2] + g.pi*((0.052725107065939 -
          0.079238375446139*o[2])*o[4] + o[10]*g.pi*(-0.00205993447006023 -
          0.02645650148281*tau2)))));

        g.gtautau := (-0.1682637354906 + g.tau*(1.429054776291 + g.tau*(-4.8852597887136
           + g.tau*(8.544491828664 + g.tau*(-8.7679022389 + o[14]*(-0.5681726521544
           + 0.12761078119842*g.tau)*g.tau)))))/(o[14]*o[15]*g.tau) + g.pi*(-0.176447663886292
           + o[2]*(-1.4466911042649 - 0.448944963879005*o[4]) + g.pi*((-2.22792871974296
           - 1.82856981808728*o[11])*o[27] + g.pi*(o[1]*(-0.0761976451887756 -
          20.6503423268611*o[12]) + g.pi*((0.316350642395634 -
          0.713145379015251*o[2])*o[27] + o[13]*g.pi*(-0.0164794757604818 -
          0.23810851334529*tau2)))));

        g.gtaupi := o[26] + g.pi*(0.0040195606760414 + (-0.742642906580988 -
          0.243809309078304*o[11])*o[4] + g.pi*((-0.0761976451887756 -
          4.13006846537222*o[12])*o[2] + g.pi*((0.210900428263756 -
          0.316953501784556*o[2])*o[4] + o[10]*g.pi*(-0.0102996723503012 -
          0.13228250741405*tau2))));
      end g2metastable;

      function f3 "Helmholtz function for region 3: f(d,T)"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      protected
        Real[40] o "vector of auxiliary variables";
      algorithm
        f.T := T;
        f.d := d;
        f.R := data.RH2O;
        f.tau := data.TCRIT/T;
        f.delta := if (d == data.DCRIT and T == data.TCRIT) then 1 - Modelica.
          Constants.eps else abs(d/data.DCRIT);
        o[1] := f.tau*f.tau;
        o[2] := o[1]*o[1];
        o[3] := o[2]*f.tau;
        o[4] := o[1]*f.tau;
        o[5] := o[2]*o[2];
        o[6] := o[1]*o[5]*f.tau;
        o[7] := o[5]*f.tau;
        o[8] := -0.64207765181607*o[1];
        o[9] := 0.88521043984318 + o[8];
        o[10] := o[7]*o[9];
        o[11] := -1.15244078066810 + o[10];
        o[12] := o[11]*o[2];
        o[13] := -1.26543154777140 + o[12];
        o[14] := o[1]*o[13];
        o[15] := o[1]*o[2]*o[5]*f.tau;
        o[16] := o[2]*o[5];
        o[17] := o[1]*o[5];
        o[18] := o[5]*o[5];
        o[19] := o[1]*o[18]*o[2];
        o[20] := o[1]*o[18]*o[2]*f.tau;
        o[21] := o[18]*o[5];
        o[22] := o[1]*o[18]*o[5];
        o[23] := 0.251168168486160*o[2];
        o[24] := 0.078841073758308 + o[23];
        o[25] := o[15]*o[24];
        o[26] := -6.1005234513930 + o[25];
        o[27] := o[26]*f.tau;
        o[28] := 9.7944563083754 + o[27];
        o[29] := o[2]*o[28];
        o[30] := -1.70429417648412 + o[29];
        o[31] := o[1]*o[30];
        o[32] := f.delta*f.delta;
        o[33] := -10.9153200808732*o[1];
        o[34] := 13.2781565976477 + o[33];
        o[35] := o[34]*o[7];
        o[36] := -6.9146446840086 + o[35];
        o[37] := o[2]*o[36];
        o[38] := -2.53086309554280 + o[37];
        o[39] := o[38]*f.tau;
        o[40] := o[18]*o[5]*f.tau;

        f.f := -15.7328452902390 + f.tau*(20.9443969743070 + (-7.6867707878716
           + o[3]*(2.61859477879540 + o[4]*(-2.80807811486200 + o[1]*(
          1.20533696965170 - 0.0084566812812502*o[6]))))*f.tau) + f.delta*(o[14]
           + f.delta*(0.38493460186671 + o[1]*(-0.85214708824206 + o[2]*(
          4.8972281541877 + (-3.05026172569650 + o[15]*(0.039420536879154 +
          0.125584084243080*o[2]))*f.tau)) + f.delta*(-0.279993296987100 + o[1]
          *(1.38997995694600 + o[1]*(-2.01899150235700 + o[16]*(-0.0082147637173963
           - 0.47596035734923*o[17]))) + f.delta*(0.043984074473500 + o[1]*(-0.44476435428739
           + o[1]*(0.90572070719733 + 0.70522450087967*o[19])) + f.delta*(f.
          delta*(-0.0221754008730960 + o[1]*(0.094260751665092 +
          0.164362784479610*o[21]) + f.delta*(-0.0135033722413480*o[1] + f.
          delta*(-0.0148343453524720*o[22] + f.delta*(o[1]*(0.00057922953628084
           + 0.0032308904703711*o[21]) + f.delta*(0.000080964802996215 -
          0.000044923899061815*f.delta*o[22] - 0.000165576797950370*f.tau)))))
           + (0.107705126263320 + o[1]*(-0.32913623258954 - 0.50871062041158*o[
          20]))*f.tau))))) + 1.06580700285130*Modelica.Math.log(f.delta);

        f.fdelta := (1.06580700285130 + f.delta*(o[14] + f.delta*(
          0.76986920373342 + o[31] + f.delta*(-0.83997989096130 + o[1]*(
          4.1699398708380 + o[1]*(-6.0569745070710 + o[16]*(-0.0246442911521889
           - 1.42788107204769*o[17]))) + f.delta*(0.175936297894000 + o[1]*(-1.77905741714956
           + o[1]*(3.6228828287893 + 2.82089800351868*o[19])) + f.delta*(f.
          delta*(-0.133052405238576 + o[1]*(0.56556450999055 + 0.98617670687766
          *o[21]) + f.delta*(-0.094523605689436*o[1] + f.delta*(-0.118674762819776
          *o[22] + f.delta*(o[1]*(0.0052130658265276 + 0.0290780142333399*o[21])
           + f.delta*(0.00080964802996215 - 0.00049416288967996*f.delta*o[22]
           - 0.00165576797950370*f.tau))))) + (0.53852563131660 + o[1]*(-1.64568116294770
           - 2.54355310205790*o[20]))*f.tau))))))/f.delta;

        f.fdeltadelta := (-1.06580700285130 + o[32]*(0.76986920373342 + o[31]
           + f.delta*(-1.67995978192260 + o[1]*(8.3398797416760 + o[1]*(-12.1139490141420
           + o[16]*(-0.049288582304378 - 2.85576214409538*o[17]))) + f.delta*(
          0.52780889368200 + o[1]*(-5.3371722514487 + o[1]*(10.8686484863680 +
          8.4626940105560*o[19])) + f.delta*(f.delta*(-0.66526202619288 + o[1]*
          (2.82782254995276 + 4.9308835343883*o[21]) + f.delta*(-0.56714163413662
          *o[1] + f.delta*(-0.83072333973843*o[22] + f.delta*(o[1]*(
          0.041704526612220 + 0.232624113866719*o[21]) + f.delta*(
          0.0072868322696594 - 0.0049416288967996*f.delta*o[22] -
          0.0149019118155333*f.tau))))) + (2.15410252526640 + o[1]*(-6.5827246517908
           - 10.1742124082316*o[20]))*f.tau)))))/o[32];

        f.ftau := 20.9443969743070 + (-15.3735415757432 + o[3]*(
          18.3301634515678 + o[4]*(-28.0807811486200 + o[1]*(14.4640436358204
           - 0.194503669468755*o[6]))))*f.tau + f.delta*(o[39] + f.delta*(f.tau
          *(-1.70429417648412 + o[2]*(29.3833689251262 + (-21.3518320798755 + o[
          15]*(0.86725181134139 + 3.2651861903201*o[2]))*f.tau)) + f.delta*((
          2.77995991389200 + o[1]*(-8.0759660094280 + o[16]*(-0.131436219478341
           - 12.3749692910800*o[17])))*f.tau + f.delta*((-0.88952870857478 + o[
          1]*(3.6228828287893 + 18.3358370228714*o[19]))*f.tau + f.delta*(
          0.107705126263320 + o[1]*(-0.98740869776862 - 13.2264761307011*o[20])
           + f.delta*((0.188521503330184 + 4.2734323964699*o[21])*f.tau + f.
          delta*(-0.0270067444826960*f.tau + f.delta*(-0.38569297916427*o[40]
           + f.delta*(f.delta*(-0.000165576797950370 - 0.00116802137560719*f.
          delta*o[40]) + (0.00115845907256168 + 0.084003152229649*o[21])*f.tau)))))))));

        f.ftautau := -15.3735415757432 + o[3]*(109.980980709407 + o[4]*(-252.727030337580
           + o[1]*(159.104479994024 - 4.2790807283126*o[6]))) + f.delta*(-2.53086309554280
           + o[2]*(-34.573223420043 + (185.894192367068 - 174.645121293971*o[1])
          *o[7]) + f.delta*(-1.70429417648412 + o[2]*(146.916844625631 + (-128.110992479253
           + o[15]*(18.2122880381691 + 81.629654758002*o[2]))*f.tau) + f.delta*
          (2.77995991389200 + o[1]*(-24.2278980282840 + o[16]*(-1.97154329217511
           - 309.374232277000*o[17])) + f.delta*(-0.88952870857478 + o[1]*(
          10.8686484863680 + 458.39592557179*o[19]) + f.delta*(f.delta*(
          0.188521503330184 + 106.835809911747*o[21] + f.delta*(-0.0270067444826960
           + f.delta*(-9.6423244791068*o[21] + f.delta*(0.00115845907256168 +
          2.10007880574121*o[21] - 0.0292005343901797*o[21]*o[32])))) + (-1.97481739553724
           - 330.66190326753*o[20])*f.tau)))));

        f.fdeltatau := o[39] + f.delta*(f.tau*(-3.4085883529682 + o[2]*(
          58.766737850252 + (-42.703664159751 + o[15]*(1.73450362268278 +
          6.5303723806402*o[2]))*f.tau)) + f.delta*((8.3398797416760 + o[1]*(-24.2278980282840
           + o[16]*(-0.39430865843502 - 37.124907873240*o[17])))*f.tau + f.
          delta*((-3.5581148342991 + o[1]*(14.4915313151573 + 73.343348091486*o[
          19]))*f.tau + f.delta*(0.53852563131660 + o[1]*(-4.9370434888431 -
          66.132380653505*o[20]) + f.delta*((1.13112901998110 +
          25.6405943788192*o[21])*f.tau + f.delta*(-0.189047211378872*f.tau + f.
           delta*(-3.08554383331418*o[40] + f.delta*(f.delta*(-0.00165576797950370
           - 0.0128482351316791*f.delta*o[40]) + (0.0104261316530551 +
          0.75602837006684*o[21])*f.tau))))))));
      end f3;

      function g5 "base function for region 5: g(p,T)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      protected
        Real[11] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function g5 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= data.PLIMIT5,
          "IF97 medium function g5: input pressure (= " + String(p) + " Pa) is higher than 10 Mpa in region 5");
        assert(T <= 2273.15,
          "IF97 medium function g5: input temperature (= " + String(T) + " K) is higher than limit of 2273.15K in region 5");
        g.p := p;
        g.T := T;
        g.R := data.RH2O;
        g.pi := p/data.PSTAR5;
        g.tau := data.TSTAR5/T;
        o[1] := g.tau*g.tau;
        o[2] := -0.0045942820899910*o[1];
        o[3] := 0.00217746787145710 + o[2];
        o[4] := o[3]*g.tau;
        o[5] := o[1]*g.tau;
        o[6] := o[1]*o[1];
        o[7] := o[6]*o[6];
        o[8] := o[7]*g.tau;
        o[9] := -7.9449656719138e-6*o[8];
        o[10] := g.pi*g.pi;
        o[11] := -0.0137828462699730*o[1];

        g.g := g.pi*(-0.000125631835895920 + o[4] + g.pi*(-3.9724828359569e-6*o[
          8] + 1.29192282897840e-7*o[5]*g.pi)) + (-0.0248051489334660 + g.tau*(
          0.36901534980333 + g.tau*(-3.11613182139250 + g.tau*(-13.1799836742010
           + (6.8540841634434 - 0.32961626538917*g.tau)*g.tau +
          Modelica.Math.log(g.pi)))))/o[5];

        g.gpi := (1.0 + g.pi*(-0.000125631835895920 + o[4] + g.pi*(o[9] +
          3.8757684869352e-7*o[5]*g.pi)))/g.pi;

        g.gpipi := (-1.00000000000000 + o[10]*(o[9] + 7.7515369738704e-7*o[5]*g.
           pi))/o[10];

        g.gtau := g.pi*(0.00217746787145710 + o[11] + g.pi*(-0.000035752345523612
          *o[7] + 3.8757684869352e-7*o[1]*g.pi)) + (0.074415446800398 + g.tau*(
          -0.73803069960666 + (3.11613182139250 + o[1]*(6.8540841634434 -
          0.65923253077834*g.tau))*g.tau))/o[6];

        g.gtautau := (-0.297661787201592 + g.tau*(2.21409209881998 + (-6.2322636427850
           - 0.65923253077834*o[5])*g.tau))/(o[6]*g.tau) + g.pi*(-0.0275656925399460
          *g.tau + g.pi*(-0.000286018764188897*o[1]*o[6]*g.tau +
          7.7515369738704e-7*g.pi*g.tau));

        g.gtaupi := 0.00217746787145710 + o[11] + g.pi*(-0.000071504691047224*o[
          7] + 1.16273054608056e-6*o[1]*g.pi);
      end g5;

      function gibbs "Gibbs function for region 1, 2 or 5: g(p,T,region)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
       input Integer region "IF97 region, 1, 2 or 5";
        output Real g "dimensionless Gibbs funcion";
      protected
        Modelica.Media.Common.GibbsDerivs gibbs
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      algorithm
        assert(region == 1 or region == 2 or region == 5,
          "IF97 medium function gibbs called with wrong region (= " + String(region) + ").\n" +
          "Only regions 1, 2 or 5 are possible");
        if region
           == 1 then
          gibbs
         := g1(p,T);
        elseif
        region == 2 then
          gibbs
         := g2(p,T);
        else
          gibbs
         := g5(p,T);
        end if;
        g :=
      gibbs.g;
      end gibbs;

      function g1pitau "derivative of g w.r.t. pi and tau"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Real pi "dimensionless pressure";
        output Real tau "dimensionless temperature";
        output Real gpi "dimensionless dervative of Gibbs function w.r.t. pi";
        output Real gtau "dimensionless dervative of Gibbs function w.r.t. tau";
      protected
        Real pi1 "dimensionless pressure";
        Real tau1 "dimensionless temperature";
        Real[28] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function g1pitau called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= 100.0e6,
          "IF97 medium function g1pitau: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
        assert(T >= 273.15,
          "IF97 medium function g1pitau: the temperature (= " + String(T) + " K) is lower than 273.15 K!");
        pi := p/data.PSTAR1;
        tau := data.TSTAR1/T;
        pi1 := 7.1 - pi;
        tau1 := -1.222 + tau;
        o[1] := tau1*tau1;
        o[2] := o[1]*tau1;
        o[3] := 1/o[2];
        o[4] := o[1]*o[1];
        o[5] := o[4]*o[4];
        o[6] := o[1]*o[5];
        o[7] := o[1]*o[4];
        o[8] := 1/o[4];
        o[9] := o[1]*o[4]*o[5];
        o[10] := o[4]*tau1;
        o[11] := 1/o[10];
        o[12] := o[4]*o[5];
        o[13] := o[5]*tau1;
        o[14] := 1/o[13];
        o[15] := pi1*pi1;
        o[16] := o[15]*pi1;
        o[17] := o[15]*o[15];
        o[18] := o[17]*o[17];
        o[19] := o[17]*o[18]*pi1;
        o[20] := o[15]*o[17];
        o[21] := o[5]*o[5];
        o[22] := o[21]*o[21];
        o[23] := o[22]*o[5]*tau1;
        o[24] := 1/o[23];
        o[25] := o[22]*o[5];
        o[26] := 1/o[25];
        o[27] := o[1]*o[22]*o[4]*tau1;
        o[28] := 1/o[27];
        gtau := pi1*((-0.00254871721114236 + o[1]*(0.00424944110961118 + (
          0.018990068218419 + (-0.021841717175414 - 0.00015851507390979*o[1])*o[
          1])*o[7]))/o[6] + pi1*(o[8]*(0.00141552963219801 + o[4]*(
          0.000047661393906987 + o[1]*(-0.0000132425535992538 -
          1.2358149370591e-14*o[9]))) + pi1*(o[11]*(0.000126718579380216 -
          5.11230768720618e-9*o[6]) + pi1*((0.000011212640954 + (
          1.30342445791202e-6 - 1.4341729937924e-12*o[12])*o[2])/o[7] + pi1*(
          3.24135974880936e-6*o[14] + o[16]*((1.40077319158051e-8 +
          1.04549227383804e-9*o[10])/o[12] + o[19]*(1.9941018075704e-17/(o[1]*o[
          21]*o[4]*o[5]) + o[15]*(-4.48827542684151e-19/o[22] + o[20]*(-1.00075970318621e-21
          *o[28] + pi1*(4.65957282962769e-22*o[26] + pi1*(-7.2912378325616e-23*
          o[24] + (3.83502057899078e-24*pi1)/(o[1]*o[22]*o[5])))))))))))) + o[3]
          *(-0.29265942426334 + tau1*(0.84548187169114 + o[1]*(3.3855169168385
           + tau1*(-1.91583926775744 + tau1*(0.47316115539684 + (-0.066465668798004
           + 0.0040607314991784*tau1)*tau1)))));
        gpi := pi1*(pi1*((0.000095038934535162 + o[4]*(8.4812393955936e-6 +
          2.55615384360309e-9*o[7]))*o[8] + pi1*(o[11]*(8.9701127632e-6 + (
          2.60684891582404e-6 + 5.7366919751696e-13*o[12])*o[2]) + pi1*(
          2.02584984300585e-6/o[5] + o[16]*(o[19]*(o[15]*(o[20]*(-7.63737668221055e-22
          /(o[1]*o[22]*o[4]) + pi1*(3.5842867920213e-22*o[28] + pi1*(-5.65070932023524e-23
          *o[26] + 2.99318679335866e-24*o[24]*pi1))) - 3.33001080055983e-19/(o[
          1]*o[21]*o[4]*o[5]*tau1)) + 1.44400475720615e-17/(o[21]*o[4]*o[5]*
          tau1)) + (1.01874413933128e-8 + 1.39398969845072e-9*o[10])/(o[1]*o[5]
          *tau1))))) + o[3]*(0.00094368642146534 + o[2]*(0.00060003561586052 +
          (-0.000095322787813974 + o[1]*(8.8283690661692e-6 +
          1.45389992595188e-15*o[9]))*tau1))) + o[14]*(-0.00028319080123804 + o[
          1]*(0.00060706301565874 + o[7]*(0.018990068218419 + tau1*(
          0.032529748770505 + (0.021841717175414 + 0.00005283835796993*o[1])*
          tau1))));
      end g1pitau;

      function g2pitau "derivative of g w.r.t. pi and tau"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Real pi "dimensionless pressure";
        output Real tau "dimensionless temperature";
        output Real gpi "dimensionless dervative of Gibbs function w.r.t. pi";
        output Real gtau "dimensionless dervative of Gibbs function w.r.t. tau";
      protected
        Real tau2 "dimensionless temperature";
        Real[22] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function g2pitau called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= 100.0e6,
          "IF97 medium function g2pitau: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
        assert(T >= 273.15,
          "IF97 medium function g2pitau: the temperature (= " + String(T) + " K) is lower than 273.15 K!");
        assert(T <= 1073.15,
          "IF97 medium function g2pitau: the input temperature (= " + String(T) + " K) is higher than the limit of 1073.15 K");
        pi := p/data.PSTAR2;
        tau := data.TSTAR2/T;
        tau2 := -0.5 + tau;
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := tau2*tau2;
        o[4] := o[3]*tau2;
        o[5] := o[3]*o[3];
        o[6] := o[5]*o[5];
        o[7] := o[6]*o[6];
        o[8] := o[5]*o[6]*o[7]*tau2;
        o[9] := o[3]*o[5];
        o[10] := o[5]*o[6]*tau2;
        o[11] := o[3]*o[7]*tau2;
        o[12] := o[3]*o[5]*o[6];
        o[13] := o[3]*o[5]*tau2;
        o[14] := o[5]*o[6]*o[7];
        o[15] := pi*pi;
        o[16] := o[15]*o[15];
        o[17] := o[15]*o[16];
        o[18] := o[5]*o[7]*tau2;
        o[19] := o[7]*o[7];
        o[20] := o[3]*o[5]*o[6]*tau2;
        o[21] := o[5]*o[7];
        o[22] := o[3]*o[7];
        gtau := (0.0280439559151 + tau*(-0.2858109552582 + tau*(1.2213149471784
           + tau*(-2.848163942888 + tau*(4.38395111945 + o[1]*(10.08665568018
           + (-0.5681726521544 + 0.06380539059921*tau)*tau))))))/(o[1]*o[2]) +
          pi*(-0.017834862292358 + tau2*(-0.09199202739273 + (-0.172743777250296
           - 0.30195167236758*o[4])*tau2) + pi*(-0.000033032641670203 + (-0.0003789797503263
           + o[3]*(-0.015757110897342 + o[4]*(-0.306581069554011 -
          0.000960283724907132*o[8])))*tau2 + pi*(4.3870667284435e-7 + o[3]*(-0.00009683303171571
           + o[4]*(-0.0090203547252888 - 1.42338887469272*o[8])) + pi*(-7.8847309559367e-10
           + (2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
          0.0000160454534363627*o[9] + pi*((-5.0144299353183e-11 + o[10]*(-0.033874355714168
           - 836.35096769364*o[11]))*o[3] + pi*((-0.0000138839897890111 -
          0.973671060893475*o[12])*o[3]*o[6] + pi*(o[13]*(9.0049690883672e-11
           - 296.320827232793*o[14]) + pi*(2.57526266427144e-7*o[5]*o[6] + pi*(
          o[4]*(4.1627860840696e-19 + (-1.0234747095929e-12 -
          1.40254511313154e-8*o[5])*o[9]) + o[17]*(o[14]*(-2.34560435076256e-9
           + 5.3465159397045*o[18]) + o[15]*(-19.1874828272775*o[19]*o[6]*o[7]
           + o[15]*(o[11]*(1.78371690710842e-23 + (1.07202609066812e-11 -
          0.000201611844951398*o[10])*o[20]) + pi*(-1.24017662339842e-24*o[21]
           + pi*(0.000200482822351322*o[19]*o[5]*o[7] + pi*(-4.97975748452559e-14
          *o[19]*o[3]*o[5] + (1.90027787547159e-27 + o[12]*(
          2.21658861403112e-15 - 0.0000547344301999018*o[22]))*o[6]*o[7]*pi*
          tau2))))))))))))))));
        gpi := (1. + pi*(-0.0017731742473213 + tau2*(-0.017834862292358 + tau2*
          (-0.045996013696365 + (-0.057581259083432 - 0.05032527872793*o[4])*
          tau2)) + pi*(tau2*(-0.000066065283340406 + (-0.0003789797503263 + o[3]
          *(-0.007878555448671 + o[4]*(-0.087594591301146 -
          0.000053349095828174*o[8])))*tau2) + pi*(6.1445213076927e-8 + (
          1.31612001853305e-6 + o[3]*(-0.00009683303171571 + o[4]*(-0.0045101773626444
           - 0.122004760687947*o[8])))*tau2 + pi*(tau2*(-3.15389238237468e-9 +
          (5.116287140914e-8 + 1.92901490874028e-6*tau2)*tau2) + pi*(
          0.0000114610381688305*o[13] + pi*((-1.00288598706366e-10 + o[10]*(-0.012702883392813
           - 143.374451604624*o[11]))*o[4] + pi*(-4.1341695026989e-17 + (-8.8352662293707e-6
           - 0.272627897050173*o[12])*o[3]*o[6]*tau2 + pi*((9.0049690883672e-11
           - 65.8490727183984*o[14])*o[6] + pi*(1.78287415218792e-7*o[10] + pi*
          (o[5]*(1.0406965210174e-18 + (-1.0234747095929e-12 -
          1.0018179379511e-8*o[5])*o[9]) + o[17]*((-1.29412653835176e-9 +
          1.71088510070544*o[18])*o[8] + o[15]*(-6.05920510335078*o[19]*o[6]*o[
          7]*tau2 + o[15]*((1.78371690710842e-23 + (6.1258633752464e-12 -
          0.000084004935396416*o[10])*o[20])*o[21] + pi*(-1.24017662339842e-24*
          o[18] + pi*(0.0000832192847496054*o[19]*o[5]*o[7]*tau2 + pi*((
          1.75410265428146e-27 + o[12]*(1.32995316841867e-15 -
          0.0000226487297378904*o[22]))*o[3]*o[6]*o[7]*pi -
          2.93678005497663e-14*o[19]*o[3]*o[5]*tau2)))))))))))))))))/pi;
      end g2pitau;

      function g5pitau "derivative of g w.r.t. pi and tau"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Real pi "dimensionless pressure";
        output Real tau "dimensionless temperature";
        output Real gpi "dimensionless dervative of Gibbs function w.r.t. pi";
        output Real gtau "dimensionless dervative of Gibbs function w.r.t. tau";
      protected
        Real[3] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function g5pitau called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        assert(p <= data.PLIMIT5,
          "IF97 medium function g5pitau: input pressure (= " + String(p) + " Pa) is higher than 10 Mpa in region 5");
        assert(T <= 2273.15,
          "IF97 medium function g5pitau: input temperature (= " + String(T) + " K) is higher than limit of 2273.15 K in region 5");
        pi := p/data.PSTAR5;
        tau := data.TSTAR5/T;
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        gtau := pi*(0.0021774678714571 - 0.013782846269973*o[1] + pi*(-0.0000357523455236121
          *o[3] + 3.8757684869352e-7*o[1]*pi)) + (0.074415446800398 + tau*(-0.73803069960666
           + (3.1161318213925 + o[1]*(6.8540841634434 - 0.65923253077834*tau))*
          tau))/o[2];
        gpi := (1.0 + pi*(-0.00012563183589592 + (0.0021774678714571 -
          0.004594282089991*o[1])*tau + pi*(-7.9449656719138e-6*o[3]*tau +
          3.8757684869352e-7*o[1]*pi*tau)))/pi;
      end g5pitau;

      function f3deltatau "1st derivatives of f w.r.t. delta and tau"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        output Real delta "dimensionless density";
        output Real tau "dimensionless temperature";
        output Real fdelta
          "dimensionless dervative of Helmholtz function w.r.t. delta";
        output Real ftau
          "dimensionless dervative of Helmholtz function w.r.t. tau";
      protected
        Real[13] o "vector of auxiliary variables";
      algorithm
        tau := data.TCRIT/T;
        delta := if (d == data.DCRIT and T == data.TCRIT) then 1 + Modelica.
          Constants.eps else d/data.DCRIT;
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*tau;
        o[5] := o[1]*o[2]*o[3]*tau;
        o[6] := o[2]*o[3];
        o[7] := o[1]*o[3];
        o[8] := o[3]*o[3];
        o[9] := o[1]*o[2]*o[8];
        o[10] := o[1]*o[2]*o[8]*tau;
        o[11] := o[3]*o[8];
        o[12] := o[1]*o[3]*o[8];
        o[13] := o[3]*o[8]*tau;
        fdelta := (1.0658070028513 + delta*(o[1]*(-1.2654315477714 + o[2]*(-1.1524407806681
           + (0.88521043984318 - 0.64207765181607*o[1])*o[4])) + delta*(
          0.76986920373342 + o[1]*(-1.70429417648412 + o[2]*(9.7944563083754 +
          (-6.100523451393 + (0.078841073758308 + 0.25116816848616*o[2])*o[5])*
          tau)) + delta*(-0.8399798909613 + o[1]*(4.169939870838 + o[1]*(-6.056974507071
           + o[6]*(-0.0246442911521889 - 1.42788107204769*o[7]))) + delta*(
          0.175936297894 + o[1]*(-1.77905741714956 + o[1]*(3.62288282878932 +
          2.82089800351868*o[9])) + delta*(delta*(-0.133052405238576 + o[1]*(
          0.565564509990552 + 0.98617670687766*o[11]) + delta*(-0.094523605689436
          *o[1] + delta*(-0.118674762819776*o[12] + delta*(o[1]*(
          0.00521306582652756 + 0.0290780142333399*o[11]) + delta*(
          0.00080964802996215 - 0.000494162889679965*delta*o[12] -
          0.0016557679795037*tau))))) + (0.5385256313166 + o[1]*(-1.6456811629477
           - 2.5435531020579*o[10]))*tau))))))/delta;
        ftau := 20.944396974307 + tau*(-15.3735415757432 + o[2]*tau*(
          18.3301634515678 + o[1]*tau*(-28.08078114862 + o[1]*(14.4640436358204
           - 0.194503669468755*o[1]*o[3]*tau)))) + delta*((-2.5308630955428 + o[
          2]*(-6.9146446840086 + (13.2781565976477 - 10.9153200808732*o[1])*o[4]))
          *tau + delta*(tau*(-1.70429417648412 + o[2]*(29.3833689251262 + (-21.3518320798755
           + (0.867251811341388 + 3.26518619032008*o[2])*o[5])*tau)) + delta*((
          2.779959913892 + o[1]*(-8.075966009428 + o[6]*(-0.131436219478341 -
          12.37496929108*o[7])))*tau + delta*((-0.88952870857478 + o[1]*(
          3.62288282878932 + 18.3358370228714*o[9]))*tau + delta*(
          0.10770512626332 + o[1]*(-0.98740869776862 - 13.2264761307011*o[10])
           + delta*((0.188521503330184 + 4.27343239646986*o[11])*tau + delta*(-0.027006744482696
          *tau + delta*(-0.385692979164272*o[13] + delta*(delta*(-0.00016557679795037
           - 0.00116802137560719*delta*o[13]) + (0.00115845907256168 +
          0.0840031522296486*o[11])*tau)))))))));
      end f3deltatau;

      function tph1 "inverse function for region 1: T(p,h)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        output SI.Temperature T "temperature (K)";
      protected
        Real pi "dimensionless pressure";
        Real eta1 "dimensionless specific enthalpy";
        Real[3] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function tph1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        pi := p/data.PSTAR2;
        eta1 := h/data.HSTAR1 + 1.0;
        o[1] := eta1*eta1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        T := -238.724899245210 - 13.3917448726020*pi + eta1*(404.21188637945 +
          43.211039183559*pi + eta1*(113.497468817180 - 54.010067170506*pi +
          eta1*(30.5358922039160*pi + eta1*(-6.5964749423638*pi + o[1]*(-5.8457616048039
           + o[2]*(pi*(0.0093965400878363 + (-0.0000258586412820730 +
          6.6456186191635e-8*pi)*pi) + o[2]*o[3]*(-0.000152854824131400 + o[1]*
          o[3]*(-1.08667076953770e-6 + pi*(1.15736475053400e-7 + pi*(-4.0644363084799e-9
           + pi*(8.0670734103027e-11 + pi*(-9.3477771213947e-13 + (
          5.8265442020601e-15 - 1.50201859535030e-17*pi)*pi))))))))))));
      end tph1;

      function tps1 "inverse function for region 1: T(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Temperature T "temperature (K)";
      protected
        constant SI.Pressure pstar=1.0e6;
        constant SI.SpecificEntropy sstar=1.0e3;
        Real pi "dimensionless pressure";
        Real sigma1 "dimensionless specific entropy";
        Real[6] o "vector of auxiliary variables";
      algorithm
        pi := p/pstar;
        assert(p > triple.ptriple,
          "IF97 medium function tps1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");

        sigma1 := s/sstar + 2.0;
        o[1] := sigma1*sigma1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*o[3];
        o[5] := o[4]*o[4];
        o[6] := o[1]*o[2]*o[4];

        T := 174.782680583070 + sigma1*(34.806930892873 + sigma1*(
          6.5292584978455 + (0.33039981775489 + o[3]*(-1.92813829231960e-7 -
          2.49091972445730e-23*o[2]*o[4]))*sigma1)) + pi*(-0.261076364893320 +
          pi*(0.00056608900654837 + pi*(o[1]*o[3]*(2.64004413606890e-13 +
          7.8124600459723e-29*o[6]) - 3.07321999036680e-31*o[5]*pi) + sigma1*(-0.00032635483139717
           + sigma1*(0.000044778286690632 + o[1]*o[2]*(-5.1322156908507e-10 -
          4.2522657042207e-26*o[6])*sigma1))) + sigma1*(0.225929659815860 +
          sigma1*(-0.064256463395226 + sigma1*(0.0078876289270526 + o[3]*sigma1
          *(3.5672110607366e-10 + 1.73324969948950e-24*o[1]*o[4]*sigma1)))));
      end tps1;

      function tph2 "reverse function for region 2: T(p,h)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        output SI.Temperature T "temperature (K)";
      protected
        Real pi "dimensionless pressure";
        Real pi2b "dimensionless pressure";
        Real pi2c "dimensionless pressure";
        Real eta "dimensionless specific enthalpy";
        Real etabc "dimensionless specific enthalpy";
        Real eta2a "dimensionless specific enthalpy";
        Real eta2b "dimensionless specific enthalpy";
        Real eta2c "dimensionless specific enthalpy";
        Real[8] o "vector of auxiliary variables";
      algorithm
        pi := p*data.IPSTAR;
        eta := h*data.IHSTAR;
        etabc := h*1.0e-3;
        if (pi < 4.0) then
          eta2a := eta - 2.1;
          o[1] := eta2a*eta2a;
          o[2] := o[1]*o[1];
          o[3] := pi*pi;
          o[4] := o[3]*o[3];
          o[5] := o[3]*pi;
          T := 1089.89523182880 + (1.84457493557900 - 0.0061707422868339*pi)*pi
             + eta2a*(849.51654495535 - 4.1792700549624*pi + eta2a*(-107.817480918260
             + (6.2478196935812 - 0.310780466295830*pi)*pi + eta2a*(
            33.153654801263 - 17.3445631081140*pi + o[2]*(-7.4232016790248 + pi
            *(-200.581768620960 + 11.6708730771070*pi) + o[1]*(271.960654737960
            *pi + o[1]*(-455.11318285818*pi + eta2a*(1.38657242832260*o[4] + o[
            1]*o[2]*(3091.96886047550*pi + o[1]*(11.7650487243560 + o[2]*(-13551.3342407750
            *o[5] + o[2]*(-62.459855192507*o[3]*o[4]*pi + o[2]*(o[4]*(
            235988.325565140 + 7399.9835474766*pi) + o[1]*(19127.7292396600*o[3]
            *o[4] + o[1]*(o[3]*(1.28127984040460e8 - 551966.97030060*o[5]) + o[
            1]*(-9.8554909623276e8*o[3] + o[1]*(2.82245469730020e9*o[3] + o[1]*
            (o[3]*(-3.5948971410703e9 + 3.7154085996233e6*o[5]) + o[1]*pi*(
            252266.403578720 + pi*(1.72273499131970e9 + pi*(1.28487346646500e7
             + (-1.31052365450540e7 - 415351.64835634*o[3])*pi))))))))))))))))))));
        elseif (pi < (0.12809002730136e-03*etabc - 0.67955786399241)*etabc +
            0.90584278514723e3) then
          eta2b := eta - 2.6;
          pi2b := pi - 2.0;
          o[1] := pi2b*pi2b;
          o[2] := o[1]*pi2b;
          o[3] := o[1]*o[1];
          o[4] := eta2b*eta2b;
          o[5] := o[4]*o[4];
          o[6] := o[4]*o[5];
          o[7] := o[5]*o[5];
          T := 1489.50410795160 + 0.93747147377932*pi2b + eta2b*(
            743.07798314034 + o[2]*(0.000110328317899990 - 1.75652339694070e-18
            *o[1]*o[3]) + eta2b*(-97.708318797837 + pi2b*(3.3593118604916 +
            pi2b*(-0.0218107553247610 + pi2b*(0.000189552483879020 + (
            2.86402374774560e-7 - 8.1456365207833e-14*o[2])*pi2b))) + o[5]*(
            3.3809355601454*pi2b + o[4]*(-0.108297844036770*o[1] + o[5]*(
            2.47424647056740 + (0.168445396719040 + o[1]*(0.00308915411605370
             - 0.0000107798573575120*pi2b))*pi2b + o[6]*(-0.63281320016026 +
            pi2b*(0.73875745236695 + (-0.046333324635812 + o[1]*(-0.000076462712454814
             + 2.82172816350400e-7*pi2b))*pi2b) + o[6]*(1.13859521296580 + pi2b
            *(-0.47128737436186 + o[1]*(0.00135555045549490 + (
            0.0000140523928183160 + 1.27049022719450e-6*pi2b)*pi2b)) + o[5]*(-0.47811863648625
             + (0.150202731397070 + o[2]*(-0.0000310838143314340 + o[1]*(-1.10301392389090e-8
             - 2.51805456829620e-11*pi2b)))*pi2b + o[5]*o[7]*(
            0.0085208123431544 + pi2b*(-0.00217641142197500 + pi2b*(
            0.000071280351959551 + o[1]*(-1.03027382121030e-6 + (
            7.3803353468292e-8 + 8.6934156344163e-15*o[3])*pi2b))))))))))));
        else
          eta2c := eta - 1.8;
          pi2c := pi + 25.0;
          o[1] := pi2c*pi2c;
          o[2] := o[1]*o[1];
          o[3] := o[1]*o[2]*pi2c;
          o[4] := 1/o[3];
          o[5] := o[1]*o[2];
          o[6] := eta2c*eta2c;
          o[7] := o[2]*o[2];
          o[8] := o[6]*o[6];
          T := eta2c*((859777.22535580 + o[1]*(482.19755109255 +
            1.12615974072300e-12*o[5]))/o[1] + eta2c*((-5.8340131851590e11 + (
            2.08255445631710e10 + 31081.0884227140*o[2])*pi2c)/o[5] + o[6]*(o[8]
            *(o[6]*(1.23245796908320e-7*o[5] + o[6]*(-1.16069211309840e-6*o[5]
             + o[8]*(0.0000278463670885540*o[5] + (-0.00059270038474176*o[5] +
            0.00129185829918780*o[5]*o[6])*o[8]))) - 10.8429848800770*pi2c) + o[
            4]*(7.3263350902181e12 + o[7]*(3.7966001272486 + (-0.045364172676660
             - 1.78049822406860e-11*o[2])*pi2c))))) + o[4]*(-3.2368398555242e12
             + pi2c*(3.5825089945447e11 + pi2c*(-1.07830682174700e10 + o[1]*
            pi2c*(610747.83564516 + pi2c*(-25745.7236041700 + (1208.23158659360
             + 1.45591156586980e-13*o[5])*pi2c)))));
        end if;
      end tph2;

      function tps2a "reverse function for region 2a: T(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Temperature T "temperature (K)";
      protected
        Real[12] o "vector of auxiliary variables";
        constant Real IPSTAR=1.0e-6 "scaling variable";
        constant Real ISSTAR2A=1/2000.0 "scaling variable";
        Real pi "dimensionless pressure";
        Real sigma2a "dimensionless specific entropy";
      algorithm
        pi := p*IPSTAR;
        sigma2a := s*ISSTAR2A - 2.0;
        o[1] := pi^0.5;
        o[2] := sigma2a*sigma2a;
        o[3] := o[2]*o[2];
        o[4] := o[3]*o[3];
        o[5] := o[4]*o[4];
        o[6] := pi^0.25;
        o[7] := o[2]*o[4]*o[5];
        o[8] := 1/o[7];
        o[9] := o[3]*sigma2a;
        o[10] := o[2]*o[3]*sigma2a;
        o[11] := o[3]*o[4]*sigma2a;
        o[12] := o[2]*sigma2a;
        T := ((-392359.83861984 + (515265.73827270 + o[3]*(40482.443161048 + o[
          2]*o[3]*(-321.93790923902 + o[2]*(96.961424218694 - 22.8678463717730*
          sigma2a))))*sigma2a)/(o[4]*o[5]) + o[6]*((-449429.14124357 + o[3]*(-5011.8336020166
           + 0.35684463560015*o[4]*sigma2a))/(o[2]*o[5]*sigma2a) + o[6]*(o[8]*(
          44235.335848190 + o[9]*(-13673.3888117080 + o[3]*(421632.60207864 + (
          22516.9258374750 + o[10]*(474.42144865646 - 149.311307976470*sigma2a))
          *sigma2a))) + o[6]*((-197811.263204520 - 23554.3994707600*sigma2a)/(o[
          2]*o[3]*o[4]*sigma2a) + o[6]*((-19070.6163020760 + o[11]*(
          55375.669883164 + (3829.3691437363 - 603.91860580567*o[2])*o[3]))*o[8]
           + o[6]*((1936.31026203310 + o[2]*(4266.0643698610 + o[2]*o[3]*o[4]*(
          -5978.0638872718 - 704.01463926862*o[9])))/(o[2]*o[4]*o[5]*sigma2a)
           + o[1]*((338.36784107553 + o[12]*(20.8627866351870 + (
          0.033834172656196 - 0.000043124428414893*o[12])*o[3]))*sigma2a + o[6]
          *(166.537913564120 + sigma2a*(-139.862920558980 + o[3]*(-0.78849547999872
           + (0.072132411753872 + o[3]*(-0.0059754839398283 + (-0.0000121413589539040
           + 2.32270967338710e-7*o[2])*o[3]))*sigma2a)) + o[6]*(-10.5384635661940
           + o[3]*(2.07189254965020 + (-0.072193155260427 + 2.07498870811200e-7
          *o[4])*o[9]) + o[6]*(o[6]*(o[12]*(0.210375278936190 +
          0.000256812397299990*o[3]*o[4]) + (-0.0127990029337810 -
          8.2198102652018e-6*o[11])*o[6]*o[9]) + o[10]*(-0.0183406579113790 +
          2.90362723486960e-7*o[2]*o[4]*sigma2a)))))))))))/(o[1]*pi);
      end tps2a;

      function tps2b "reverse function for region 2b: T(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Temperature T "temperature (K)";
      protected
        Real[8] o "vector of auxiliary variables";
        constant Real IPSTAR=1.0e-6 "scaling variable";
        constant Real ISSTAR2B=1/785.3 "scaling variable";
        Real pi "dimensionless pressure";
        Real sigma2b "dimensionless specific entropy";
      algorithm
        pi := p*IPSTAR;
        sigma2b := 10.0 - s*ISSTAR2B;
        o[1] := pi*pi;
        o[2] := o[1]*o[1];
        o[3] := sigma2b*sigma2b;
        o[4] := o[3]*o[3];
        o[5] := o[4]*o[4];
        o[6] := o[3]*o[5]*sigma2b;
        o[7] := o[3]*o[5];
        o[8] := o[3]*sigma2b;
        T := (316876.65083497 + 20.8641758818580*o[6] + pi*(-398593.99803599 -
          21.8160585188770*o[6] + pi*(223697.851942420 + (-2784.17034458170 +
          9.9207436071480*o[7])*sigma2b + pi*(-75197.512299157 + (
          2970.86059511580 + o[7]*(-3.4406878548526 + 0.38815564249115*sigma2b))
          *sigma2b + pi*(17511.2950857500 + sigma2b*(-1423.71128544490 + (
          1.09438033641670 + 0.89971619308495*o[4])*o[4]*sigma2b) + pi*(-3375.9740098958
           + (471.62885818355 + o[4]*(-1.91882419936790 + o[8]*(
          0.41078580492196 - 0.33465378172097*sigma2b)))*sigma2b + pi*(
          1387.00347775050 + sigma2b*(-406.63326195838 + sigma2b*(
          41.727347159610 + o[3]*(2.19325494345320 + sigma2b*(-1.03200500090770
           + (0.35882943516703 + 0.0052511453726066*o[8])*sigma2b)))) + pi*(
          12.8389164507050 + sigma2b*(-2.86424372193810 + sigma2b*(
          0.56912683664855 + (-0.099962954584931 + o[4]*(-0.0032632037778459 +
          0.000233209225767230*sigma2b))*sigma2b)) + pi*(-0.153348098574500 + (
          0.0290722882399020 + 0.00037534702741167*o[4])*sigma2b + pi*(
          0.00172966917024110 + (-0.00038556050844504 - 0.000035017712292608*o[
          3])*sigma2b + pi*(-0.0000145663936314920 + 5.6420857267269e-6*sigma2b
           + pi*(4.1286150074605e-8 + (-2.06846711188240e-8 +
          1.64093936747250e-9*sigma2b)*sigma2b))))))))))))/(o[1]*o[2]);
      end tps2b;

      function tps2c "reverse function for region 2c: T(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Temperature T "temperature (K)";
      protected
        constant Real IPSTAR=1.0e-6 "scaling variable";
        constant Real ISSTAR2C=1/2925.1 "scaling variable";
        Real pi "dimensionless pressure";
        Real sigma2c "dimensionless specific entropy";
        Real[3] o "vector of auxiliary variables";
      algorithm
        pi := p*IPSTAR;
        sigma2c := 2.0 - s*ISSTAR2C;
        o[1] := pi*pi;
        o[2] := sigma2c*sigma2c;
        o[3] := o[2]*o[2];
        T := (909.68501005365 + 2404.56670884200*sigma2c + pi*(-591.62326387130
           + pi*(541.45404128074 + sigma2c*(-270.983084111920 + (
          979.76525097926 - 469.66772959435*sigma2c)*sigma2c) + pi*(
          14.3992746047230 + (-19.1042042304290 + o[2]*(5.3299167111971 -
          21.2529753759340*sigma2c))*sigma2c + pi*(-0.311473344137600 + (
          0.60334840894623 - 0.042764839702509*sigma2c)*sigma2c + pi*(
          0.0058185597255259 + (-0.0145970082847530 + 0.0056631175631027*o[3])*
          sigma2c + pi*(-0.000076155864584577 + sigma2c*(0.000224403429193320
           - 0.0000125610950134130*o[2]*sigma2c) + pi*(6.3323132660934e-7 + (-2.05419896753750e-6
           + 3.6405370390082e-8*sigma2c)*sigma2c + pi*(-2.97598977892150e-9 +
          1.01366185297630e-8*sigma2c + pi*(5.9925719692351e-12 + sigma2c*(-2.06778701051640e-11
           + o[2]*(-2.08742781818860e-11 + (1.01621668250890e-10 -
          1.64298282813470e-10*sigma2c)*sigma2c))))))))))))/o[1];
      end tps2c;

      function tps2 "reverse function for region 2: T(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Temperature T "temperature (K)";
      protected
        Real pi "dimensionless pressure";
        constant SI.SpecificEntropy SLIMIT=5.85e3
          "subregion boundary specific entropy between regions 2a and 2b";
      algorithm
        if p < 4.0e6 then
          T := tps2a(p, s);
        elseif s > SLIMIT then
          T := tps2b(p, s);
        else
          T := tps2c(p, s);
        end if;
      end tps2;

      function tsat "region 4 saturation temperature as a function of pressure"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Temperature t_sat "temperature";
      protected
        Real pi "dimensionless pressure";
        Real[20] o "vector of auxiliary variables";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function tsat called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
      //  assert(p <= data.PCRIT,
      //    "tsat: input pressure is higher than the critical point pressure");
        pi := min(p,data.PCRIT)*data.IPSTAR;
        o[1] := pi^0.25;
        o[2] := -3.2325550322333e6*o[1];
        o[3] := pi^0.5;
        o[4] := -724213.16703206*o[3];
        o[5] := 405113.40542057 + o[2] + o[4];
        o[6] := -17.0738469400920*o[1];
        o[7] := 14.9151086135300 + o[3] + o[6];
        o[8] := -4.0*o[5]*o[7];
        o[9] := 12020.8247024700*o[1];
        o[10] := 1167.05214527670*o[3];
        o[11] := -4823.2657361591 + o[10] + o[9];
        o[12] := o[11]*o[11];
        o[13] := o[12] + o[8];
        o[14] := o[13]^0.5;
        o[15] := -o[14];
        o[16] := -12020.8247024700*o[1];
        o[17] := -1167.05214527670*o[3];
        o[18] := 4823.2657361591 + o[15] + o[16] + o[17];
        o[19] := 1/o[18];
        o[20] := 2.0*o[19]*o[5];

        t_sat := 0.5*(650.17534844798 + o[20] - (-4.0*(-0.238555575678490 +
          1300.35069689596*o[19]*o[5]) + (650.17534844798 + o[20])^2.0)^0.5);
        annotation (derivative=tsat_der);
      end tsat;

      function dtsatofp "derivative of saturation temperature w.r.t. pressure"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output Real dtsat(unit="K/Pa") "derivative of T w.r.t. p";
      protected
        Real pi "dimensionless pressure";
        Real[49] o "vector of auxiliary variables";
      algorithm
        pi := max(Modelica.Constants.small,p*data.IPSTAR);
        o[1] := pi^0.75;
        o[2] := 1/o[1];
        o[3] := -4.268461735023*o[2];
        o[4] := sqrt(pi);
        o[5] := 1/o[4];
        o[6] := 0.5*o[5];
        o[7] := o[3] + o[6];
        o[8] := pi^0.25;
        o[9] := -3.2325550322333e6*o[8];
        o[10] := -724213.16703206*o[4];
        o[11] := 405113.40542057 + o[10] + o[9];
        o[12] := -4*o[11]*o[7];
        o[13] := -808138.758058325*o[2];
        o[14] := -362106.58351603*o[5];
        o[15] := o[13] + o[14];
        o[16] := -17.073846940092*o[8];
        o[17] := 14.91510861353 + o[16] + o[4];
        o[18] := -4*o[15]*o[17];
        o[19] := 3005.2061756175*o[2];
        o[20] := 583.52607263835*o[5];
        o[21] := o[19] + o[20];
        o[22] := 12020.82470247*o[8];
        o[23] := 1167.0521452767*o[4];
        o[24] := -4823.2657361591 + o[22] + o[23];
        o[25] := 2.0*o[21]*o[24];
        o[26] := o[12] + o[18] + o[25];
        o[27] := -4.0*o[11]*o[17];
        o[28] := o[24]*o[24];
        o[29] := o[27] + o[28];
        o[30] := sqrt(o[29]);
        o[31] := 1/o[30];
        o[32] := (-o[30]);
        o[33] := -12020.82470247*o[8];
        o[34] := -1167.0521452767*o[4];
        o[35] := 4823.2657361591 + o[32] + o[33] + o[34];
        o[36] := o[30];
        o[37] := -4823.2657361591 + o[22] + o[23] + o[36];
        o[38] := o[37]*o[37];
        o[39] := 1/o[38];
        o[40] := -1.72207339365771*o[30];
        o[41] := 21592.2055343628*o[8];
        o[42] := o[30]*o[8];
        o[43] := -8192.87114842946*o[4];
        o[44] := -0.510632954559659*o[30]*o[4];
        o[45] := -3100.02526152368*o[1];
        o[46] := pi;
        o[47] := 1295.95640782102*o[46];
        o[48] := 2862.09212505088 + o[40] + o[41] + o[42] + o[43] + o[44] + o[
          45] + o[47];
        o[49] := 1/(o[35]*o[35]);
        dtsat := data.IPSTAR*0.5*((2.0*o[15])/o[35] - 2.*o[11]*(-3005.2061756175
          *o[2] - 0.5*o[26]*o[31] - 583.52607263835*o[5])*o[49] - (
          20953.46356643991*(o[39]*(1295.95640782102 + 5398.05138359071*o[2] +
          0.25*o[2]*o[30] - 0.861036696828853*o[26]*o[31] - 0.255316477279829*o[
          26]*o[31]*o[4] - 4096.43557421473*o[5] - 0.255316477279829*o[30]*o[5]
           - 2325.01894614276/o[8] + 0.5*o[26]*o[31]*o[8]) - 2.0*(o[19] + o[20]
           + 0.5*o[26]*o[31])*o[48]*o[37]^(-3)))/sqrt(o[39]*o[48]));
      end dtsatofp;

      function tsat_der "derivative function for tsat"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input Real der_p(unit="Pa/s") "pressure derivatrive";
        output Real der_tsat(unit="K/s") "temperature derivative";
      protected
        Real dtp;
      algorithm
        dtp := dtsatofp(p);
        der_tsat := dtp*der_p;
      end tsat_der;

      function psat
        "region 4 saturation pressure as a functionx of temperature"

        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature (K)";
        output SI.Pressure p_sat "pressure";
      protected
        Real[8] o "vector of auxiliary variables";
        Real Tlim=min(T, data.TCRIT);
      algorithm
        assert(T >= 273.16,
          "IF97 medium function psat: input temperature (= " + String(triple.ptriple) + " K).\n" +
          "lower than the triple point temperature 273.16 K");
        o[1] := -650.17534844798 + Tlim;
        o[2] := 1/o[1];
        o[3] := -0.238555575678490*o[2];
        o[4] := o[3] + Tlim;
        o[5] := -4823.2657361591*o[4];
        o[6] := o[4]*o[4];
        o[7] := 14.9151086135300*o[6];
        o[8] := 405113.40542057 + o[5] + o[7];
        p_sat := 16.0e6*o[8]*o[8]*o[8]*o[8]*1/(3.2325550322333e6 -
          12020.8247024700*o[4] + 17.0738469400920*o[6] + (-4.0*(-724213.16703206
           + 1167.05214527670*o[4] + o[6])*o[8] + (-3.2325550322333e6 +
          12020.8247024700*o[4] - 17.0738469400920*o[6])^2.0)^0.5)^4.0;
        annotation (derivative=psat_der);
      end psat;

      function dptofT
        "derivative of pressure w.r.t. temperature along the saturation pressure curve"

        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature (K)";
        output Real dpt(unit = "Pa/K") "temperature derivative of pressure";
      protected
        Real[31] o "vector of auxiliary variables";
        Real Tlim "temeprature limited to TCRIT";
      algorithm
        Tlim := min(T, data.TCRIT);
        o[1] := -650.17534844798 + Tlim;
        o[2] := 1/o[1];
        o[3] := -0.238555575678490*o[2];
        o[4] := o[3] + Tlim;
        o[5] := -4823.2657361591*o[4];
        o[6] := o[4]*o[4];
        o[7] := 14.9151086135300*o[6];
        o[8] := 405113.40542057 + o[5] + o[7];
        o[9] := o[8]*o[8];
        o[10] := o[9]*o[9];
        o[11] := o[1]*o[1];
        o[12] := 1/o[11];
        o[13] := 0.238555575678490*o[12];
        o[14] := 1.00000000000000 + o[13];
        o[15] := 12020.8247024700*o[4];
        o[16] := -17.0738469400920*o[6];
        o[17] := -3.2325550322333e6 + o[15] + o[16];
        o[18] := -4823.2657361591*o[14];
        o[19] := 29.8302172270600*o[14]*o[4];
        o[20] := o[18] + o[19];
        o[21] := 1167.05214527670*o[4];
        o[22] := -724213.16703206 + o[21] + o[6];
        o[23] := o[17]*o[17];
        o[24] := -4.0000000000000*o[22]*o[8];
        o[25] := o[23] + o[24];
        o[26] := sqrt(o[25]);
        o[27] := -12020.8247024700*o[4];
        o[28] := 17.0738469400920*o[6];
        o[29] := 3.2325550322333e6 + o[26] + o[27] + o[28];
        o[30] := o[29]*o[29];
        o[31] := o[30]*o[30];
        dpt := 1e6*((-64.0*o[10]*(-12020.8247024700*o[14] + 34.147693880184*o[
          14]*o[4] + (0.5*(-4.0*o[20]*o[22] + 2.00000000000000*o[17]*(
          12020.8247024700*o[14] - 34.147693880184*o[14]*o[4]) - 4.0*(
          1167.05214527670*o[14] + 2.0*o[14]*o[4])*o[8]))/o[26]))/(o[29]*o[31])
           + (64.*o[20]*o[8]*o[9])/o[31]);
      end dptofT;

      function psat_der "derivative function for psat"
        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature (K)";
        input Real der_T(unit = "K/s") "temperature derivative";
        output Real der_psat(unit = "Pa/s") "pressure";
      protected
        Real dpt;
      algorithm
        dpt := dptofT(T);
        der_psat := dpt*der_T;
      end psat_der;

      // Inverses p_hs from the 2001 assition to IAPWS97
      function p1_hs
        "pressure as a function of ehtnalpy and entropy in region 1"
        extends Modelica.Icons.Function;
        input SI.SpecificEnthalpy h "specific enthalpy";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Pressure p "Pressure";
        constant Real[:] n=
          {-0.691997014660582,-0.183612548787560e2,-0.928332409297335e1,0.659639569909906e2,
           -0.162060388912024e2,0.450620017338667e3,0.854680678224170e3,0.607523214001162e4,0.326487682621856e2,
           -0.269408844582931e2,-0.319947848334300e3,-0.928354307043320e3,0.303634537455249e2,-0.650540422444146e2,
           -0.430991316516130e4,-0.747512324096068e3,0.730000345529245e3,0.114284032569021e4,-0.436407041874559e3};
        constant Real[:] I = {0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,3,4,4,5};
        constant Real[:] J = {0,1,2,4,5,6,8,14,0,1,4,6,0,1,10,4,1,4,0};
        constant SI.SpecificEnthalpy hstar = 3400e3 "normalization enthalpy";
        constant SI.Pressure pstar = 100e6 "normalization pressure";
        constant SI.SpecificEntropy sstar = 7.6e3 "normalization entropy";
      protected
        Real eta = h/hstar "normalized specific enthalpy";
        Real sigma = s/sstar "normalized specific entropy";
      algorithm
        p := sum(n[i]*(eta + 0.05)^I[i]*(sigma + 0.05)^J[i] for i in 1:19)*pstar;
        annotation (
            Documentation(                                                                                                    info="<html>
<p>
  Equation number 1 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Gaithersburg, Maryland, USA<br>
  September 2001<br>
  Supplementary Release on&nbsp; Backward Equations for Pressure as a
  Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
  Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
  </html>
  "));
      end p1_hs;

      function h2ab_s "boundary between regions 2a and 2b"
        extends Modelica.Icons.Function;
        output SI.SpecificEnthalpy h "Enthalpy";
        input SI.SpecificEntropy s "Entropy";
      protected
        constant Real[:] n = {-0.349898083432139e4,0.257560716905876e4,-0.421073558227969e3,0.276349063799944e2};
        constant SI.SpecificEnthalpy hstar = 1e3 "normalization enthalpy";
        constant SI.SpecificEntropy sstar = 1e3 "normalization entropy";
        Real sigma = s/sstar "normalized specific entropy";
      algorithm
        h := (n[1] + n[2]*sigma + n[3]*sigma^2 + n[4]*sigma^3)*hstar;
        annotation (
            Documentation(                                                                                                    info="<html>
  <p>
  Equation number 2 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Gaithersburg, Maryland, USA<br>
  September 2001<br>
  Supplementary Release on&nbsp; Backward Equations for Pressure as a
  Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
  Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
  </html>
  "));
      end h2ab_s;

      function p2a_hs
        "pressure as a function of enthalpy and entropy in subregion 2a"
        extends Modelica.Icons.Function;
        input SI.SpecificEnthalpy h "specific enthalpy";
        input SI.SpecificEntropy s "specific entropy";
        output SI.Pressure p "Pressure";
        constant Real[:] n=
          {-0.182575361923032e-1,-0.125229548799536,0.592290437320145,0.604769706185122e1,
           0.238624965444474e3,-0.298639090222922e3,0.512250813040750e-1,-0.437266515606486,0.413336902999504,
           -0.516468254574773e1,-0.557014838445711e1,0.128555037824478e2,0.114144108953290e2,-0.119504225652714e3,
           -0.284777985961560e4,0.431757846408006e4,0.112894040802650e1,0.197409186206319e4,0.151612444706087e4,
           0.141324451421235e-1,0.585501282219601,-0.297258075863012e1,0.594567314847319e1,-0.623656565798905e4,
           0.965986235133332e4,0.681500934948134e1,-0.633207286824489e4,-0.558919224465760e1,0.400645798472063e-1};
        constant Real[:] I = {0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,3,3,3,3,3,4,5,5,6,7};
        constant Real[:] J = {1,3,6,16,20,22,0,1,2,3,5,6,10,16,20,22,3,16,20,0,2,3,6,16,16,3,16,3,1};
        constant SI.SpecificEnthalpy hstar = 4200e3 "normalization enthalpy";
        constant SI.Pressure pstar = 4e6 "normalization pressure";
        constant SI.SpecificEntropy sstar = 12e3 "normalization entropy";
      protected
        Real eta = h/hstar "normalized specific enthalpy";
        Real sigma = s/sstar "normalized specific entropy";
      algorithm
        p := sum(n[i]*(eta - 0.5)^I[i]*(sigma - 1.2)^J[i] for i in 1:29)^4*pstar;
        annotation (
            Documentation(                                                                                                    info="<html>
  <p>
  Equation number 3 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Gaithersburg, Maryland, USA<br>
  September 2001<br>
  Supplementary Release on&nbsp; Backward Equations for Pressure as a
  Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
  Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
  </html>
  "));
      end p2a_hs;

    function p2b_hs
        "pressure as a function of enthalpy and entropy in subregion 2a"
      extends Modelica.Icons.Function;
      input SI.SpecificEnthalpy h "specific enthalpy";
      input SI.SpecificEntropy s "specific entropy";
      output SI.Pressure p "Pressure";
      constant Real[:] n=
        {0.801496989929495e-1,-0.543862807146111,0.337455597421283,0.890555451157450e1,
         0.313840736431485e3,0.797367065977789,-0.121616973556240e1,0.872803386937477e1,-0.169769781757602e2,
         -0.186552827328416e3,0.951159274344237e5,-0.189168510120494e2,-0.433407037194840e4,0.543212633012715e9,
         0.144793408386013,0.128024559637516e3,-0.672309534071268e5,0.336972380095287e8,-0.586634196762720e3,
         -0.221403224769889e11,0.171606668708389e4,-0.570817595806302e9,-0.312109693178482e4,-0.207841384633010e7,
         0.305605946157786e13,0.322157004314333e4,0.326810259797295e12,-0.144104158934487e4,0.410694867802691e3,
         0.109077066873024e12,-0.247964654258893e14,0.188801906865134e10,-0.123651009018773e15};
      constant Real[:] I = {0,0,0,0,0,1,1,1,1,1,1,2,2,2,3,3,3,3,4,4,5,5,6,6,6,7,7,8,8,8,8,12,14};
      constant Real[:] J = {0,1,2,4,8,0,1,2,3,5,12,1,6,18,0,1,7,12,1,16,1,12,1,8,18,1,16,1,3,14,18,10,16};
      constant SI.SpecificEnthalpy hstar = 4100e3 "normalization enthalpy";
      constant SI.Pressure pstar = 100e6 "normalization pressure";
      constant SI.SpecificEntropy sstar = 7.9e3 "normalization entropy";
      protected
      Real eta = h/hstar "normalized specific enthalpy";
      Real sigma = s/sstar "normalized specific entropy";
    algorithm
      p := sum(n[i]*(eta - 0.6)^I[i]*(sigma - 1.01)^J[i] for i in 1:33)^4*pstar;
      annotation (
            Documentation(                                                                                                    info="<html>
<p>
Equation number 4 from:<br>
The International Association for the Properties of Water and Steam<br>
Gaithersburg, Maryland, USA<br>
September 2001<br>
Supplementary Release on&nbsp; Backward Equations for Pressure as a
Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
</p>
      </html>
"));
    end p2b_hs;

      function p2c_hs
        "pressure as a function of enthalpy and entropy in subregion 2c"
          extends Modelica.Icons.Function;
          input SI.SpecificEnthalpy h "specific enthalpy";
          input SI.SpecificEntropy s "specific entropy";
          output SI.Pressure p "Pressure";
          constant Real[:] n=
            {0.112225607199012,-0.339005953606712e1,-0.320503911730094e2,-0.197597305104900e3,
             -0.407693861553446e3,0.132943775222331e5,0.170846839774007e1,0.373694198142245e2,0.358144365815434e4,
             0.423014446424664e6,-0.751071025760063e9,0.523446127607898e2,-0.228351290812417e3,-0.960652417056937e6,
             -0.807059292526074e8,0.162698017225669e13,0.772465073604171,0.463929973837746e5,-0.137317885134128e8,
             0.170470392630512e13,-0.251104628187308e14,0.317748830835520e14,0.538685623675312e2,-0.553089094625169e5,
             -0.102861522421405e7,0.204249418756234e13,0.273918446626977e9,-0.263963146312685e16,-0.107890854108088e10,
             -0.296492620980124e11,-0.111754907323424e16};
          constant Real[:] I = {0,0,0,0,0,0,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,5,5,5,5,6,6,10,12,16};
          constant Real[:] J = {0,1,2,3,4,8,0,2,5,8,14,2,3,7,10,18,0,5,8,16,18,18,1,4,6,14,8,18,7,7,10};
          constant SI.SpecificEnthalpy hstar = 3500e3 "normalization enthalpy";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEntropy sstar = 5.9e3 "normalization entropy";
      protected
          Real eta = h/hstar "normalized specific enthalpy";
          Real sigma = s/sstar "normalized specific entropy";
      algorithm
          p := sum(n[i]*(eta - 0.7)^I[i]*(sigma - 1.1)^J[i] for i in 1:31)^4*pstar;
          annotation (
            Documentation(                                                                                                    info="<html>
      <p>
      Equation number 5 from:<br>
      The International Association for the Properties of Water and Steam<br>
      Gaithersburg, Maryland, USA<br>
      September 2001<br>
      Supplementary Release on&nbsp; Backward Equations for Pressure as a
      Function of Enthalpy and Entropy p(h,s) to the IAPWS Industrial
      Formulation 1997 for the Thermodynamic Properties of Water and Steam<br>
   </p>
      </html>
      "));
      end p2c_hs;

      // Inverses from the 2003 additions to IF97
      function h3ab_p "ergion 3 a b boundary for pressure/enthalpy"
          extends Modelica.Icons.Function;
          output SI.SpecificEnthalpy h "Enthalpy";
          input SI.Pressure p "Pressure";
      protected
          constant Real[:] n = {0.201464004206875e4,0.374696550136983e1,-0.219921901054187e-1,0.875131686009950e-4};
          constant SI.SpecificEnthalpy hstar = 1000 "normalization enthalpy";
          constant SI.Pressure pstar = 1e6 "normalization pressure";
          Real pi = p/pstar "normalized specific pressure";

      algorithm
          h := (n[1] + n[2]*pi + n[3]*pi^2 + n[4]*pi^3)*hstar;
          annotation (
      Documentation(info="<html>
      <p>
      &nbsp;Equation number 1 from:<br>
      <div style=\"text-align: center;\">&nbsp;[1] The international Association
      for the Properties of Water and Steam<br>
      &nbsp;Vejle, Denmark<br>
      &nbsp;August 2003<br>
      &nbsp;Supplementary Release on Backward Equations for the Fucnctions
      T(p,h), v(p,h) and T(p,s), <br>
      &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
      the Thermodynamic Properties of<br>
      &nbsp;Water and Steam</div>
   </p>
      </html>"));
      end h3ab_p;

      function T3a_ph "Region 3 a: inverse function T(p,h)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "specific enthalpy";
          output SI.Temp_K T "Temperature";
      protected
          constant Real[:] n=
            {-0.133645667811215e-6,0.455912656802978e-5,-0.146294640700979e-4, 0.639341312970080e-2,0.372783927268847e3,
             -0.718654377460447e4,0.573494752103400e6,-0.267569329111439e7,-0.334066283302614e-4,-0.245479214069597e-1,
             0.478087847764996e2,0.764664131818904e-5,0.128350627676972e-2,0.171219081377331e-1,-0.851007304583213e1,
             -0.136513461629781e-1,-0.384460997596657e-5,0.337423807911655e-2,-0.551624873066791,0.729202277107470,
             -0.992522757376041e-2,-0.119308831407288,0.793929190615421,0.454270731799386,0.209998591259910,
             -0.642109823904738e-2,-0.235155868604540e-1,0.252233108341612e-2,-0.764885133368119e-2,0.136176427574291e-1,
             -0.133027883575669e-1};
          constant Real[:] I = {-12,-12,-12,-12,-12,-12,-12,-12,-10,-10,
                                -10,-8,-8,-8,-8,-5,-3,-2,-2,-2,-1,-1,0,0,1,3,3,4,4,10,12};
          constant Real[:] J = { 0,1,2,6,14,16,20,22,1,5,12,0,2,4,10,2,0,1,3,4,0,2,0,1,1,0,1,0,3,4,5};
          constant SI.SpecificEnthalpy hstar = 2300e3 "normalization enthalpy";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.Temp_K Tstar = 760 "normalization temperature";
          Real pi = p/pstar "normalized specific pressure";
          Real eta = h/hstar "normalized specific enthalpy";
      algorithm
          T := sum(n[i]*(pi + 0.240)^I[i]*(eta - 0.615)^J[i] for i in 1:31)*Tstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 2 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end T3a_ph;

      function T3b_ph "Region 3 b: inverse function T(p,h)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "specific enthalpy";
          output SI.Temp_K T "Temperature";
      protected
          constant Real[:] n=
            {0.323254573644920e-4,-0.127575556587181e-3,-0.475851877356068e-3,0.156183014181602e-2,
             0.105724860113781,-0.858514221132534e2,0.724140095480911e3,0.296475810273257e-2,-0.592721983365988e-2,
             -0.126305422818666e-1,-0.115716196364853,0.849000969739595e2,-0.108602260086615e-1,0.154304475328851e-1,
             0.750455441524466e-1,0.252520973612982e-1,-0.602507901232996e-1,-0.307622221350501e1,-0.574011959864879e-1,
             0.503471360939849e1,-0.925081888584834,0.391733882917546e1,-0.773146007130190e2,0.949308762098587e4,
             -0.141043719679409e7,0.849166230819026e7,0.861095729446704,0.323346442811720,0.873281936020439,
             -0.436653048526683,0.286596714529479,-0.131778331276228,0.676682064330275e-2};
          constant Real[:] I = {-12,-12,-10,-10,-10,-10,-10,-8,-8,-8,-8,
                                -8,-6,-6,-6,-4,-4,-3,-2,-2,-1,-1,-1,-1,-1,-1,0,0,1,3,5,6,8};
          constant Real[:] J = {0,1,0,1,5,10,12,0,1,2,4,10,0,1,2,0,1,5,0,4,2,4,6,10,14,16,0,2,1,1,1,1,1};
          constant SI.Temp_K Tstar = 860 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEnthalpy hstar = 2800e3 "normalization enthalpy";
          Real pi = p/pstar "normalized specific pressure";
          Real eta = h/hstar "normalized specific enthalpy";
      algorithm
          T := sum(n[i]*(pi + 0.298)^I[i]*(eta - 0.720)^J[i] for i in 1:33)*Tstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 3 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end T3b_ph;

      function v3a_ph "Region 3 a: inverse function v(p,h)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "specific enthalpy";
          output SI.SpecificVolume v "specific volume";
      protected
          constant Real[:] n=
            { 0.529944062966028e-2,-0.170099690234461,0.111323814312927e2,-0.217898123145125e4,
             -0.506061827980875e-3,0.556495239685324,-0.943672726094016e1,-0.297856807561527,0.939353943717186e2,
             0.192944939465981e-1,0.421740664704763,-0.368914126282330e7,-0.737566847600639e-2,-0.354753242424366,
             -0.199768169338727e1,0.115456297059049e1,0.568366875815960e4,0.808169540124668e-2,0.172416341519307,
             0.104270175292927e1,-0.297691372792847,0.560394465163593,0.275234661176914,-0.148347894866012,
             -0.651142513478515e-1,-0.292468715386302e1,0.664876096952665e-1,0.352335014263844e1,-0.146340792313332e-1,
             -0.224503486668184e1,0.110533464706142e1,-0.408757344495612e-1};
          constant Real[:] I = {-12,-12,-12,-12,-10,-10,-10,-8,-8,-6,
                                -6,-6,-4,-4,-3,-2,-2,-1,-1,-1,-1,0,0,1,1,1,2,2,3,4,5,8};
          constant Real[:] J = {6,8,12,18,4,7,10,5,12,3,4,22,2,3,7,3,16,0,1,2,3,0,1,0,1,2,0,2,0,2,2,2};
          constant SI.Volume vstar = 0.0028 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEnthalpy hstar = 2100e3 "normalization enthalpy";
          Real pi = p/pstar "normalized specific pressure";
          Real eta = h/hstar "normalized specific enthalpy";
      algorithm
          v := sum(n[i]*(pi + 0.128)^I[i]*(eta - 0.727)^J[i] for i in 1:32)*vstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 4 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end v3a_ph;

      function v3b_ph "Region 3 b: inverse function v(p,h)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "specific enthalpy";
          output SI.SpecificVolume v "specific volume";
      protected
          constant Real[:] n=
            { -0.225196934336318e-8,0.140674363313486e-7,0.233784085280560e-5,-0.331833715229001e-4,
             0.107956778514318e-2,-0.271382067378863,0.107202262490333e1,-0.853821329075382,-0.215214194340526e-4,
             0.769656088222730e-3,-0.431136580433864e-2,0.453342167309331,-0.507749535873652,-0.100475154528389e3,
             -0.219201924648793,-0.321087965668917e1,0.607567815637771e3,0.557686450685932e-3,0.187499040029550,
             0.905368030448107e-2,0.285417173048685,0.329924030996098e-1,0.239897419685483,0.482754995951394e1,
             -0.118035753702231e2,0.169490044091791,-0.179967222507787e-1,0.371810116332674e-1,-0.536288335065096e-1,
             0.160697101092520e1};
          constant Real[:] I = {-12,-12,-8,-8,-8,-8,-8,-8,-6,-6,
                                -6,-6,-6,-6,-4,-4,-4,-3,-3,-2,-2,-1,-1,-1,-1,0,1,1,2,2};
          constant Real[:] J = {0,1,0,1,3,6,7,8,0,1,2,5,6,10,3,6,10,0,2,1,2,0,1,4,5,0,0,1,2,6};
          constant SI.Volume vstar = 0.0088 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEnthalpy hstar = 2800e3 "normalization enthalpy";
          Real pi = p/pstar "normalized specific pressure";
          Real eta = h/hstar "normalized specific enthalpy";
      algorithm
          v := sum(n[i]*(pi + 0.0661)^I[i]*(eta - 0.720)^J[i] for i in 1:30)*vstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 5 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end v3b_ph;

      function T3a_ps "Region 3 a: inverse function T(p,s)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "specific entropy";
          output SI.Temp_K T "Temperature";
      protected
          constant Real[:] n=
            {0.150042008263875e10,-0.159397258480424e12,0.502181140217975e-3,-0.672057767855466e2,
             0.145058545404456e4,-0.823889534888890e4,-0.154852214233853,0.112305046746695e2,-0.297000213482822e2,
             0.438565132635495e11,0.137837838635464e-2,-0.297478527157462e1,0.971777947349413e13,-0.571527767052398e-4,
             0.288307949778420e5,-0.744428289262703e14,0.128017324848921e2,-0.368275545889071e3,0.664768904779177e16,
             0.449359251958880e-1,-0.422897836099655e1,-0.240614376434179,-0.474341365254924e1,0.724093999126110,
             0.923874349695897,0.399043655281015e1,0.384066651868009e-1,-0.359344365571848e-2,-0.735196448821653,
             0.188367048396131,0.141064266818704e-3,-0.257418501496337e-2,0.123220024851555e-2};
          constant Real[:] I = {-12,-12,-10,-10,-10,-10,-8,-8,
                                -8,-8,-6,-6,-6,-5,-5,-5,-4,-4,-4,-2,-2,-1,-1,0,0,0,1,2,2,3,8,8,10};
          constant Real[:] J = {28,32,4,10,12,14,5,7,8,28,2,6,32,0,14,32,6,10,36,1,4,1,6,0,1,4,0,0,3,2,0,1,2};
          constant SI.Temp_K Tstar = 760 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEntropy sstar = 4.4e3 "normalization entropy";
          Real pi = p/pstar "normalized specific pressure";
          Real sigma = s/sstar "normalized specific entropy";
      algorithm
          T := sum(n[i]*(pi + 0.240)^I[i]*(sigma - 0.703)^J[i] for i in 1:33)*Tstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 6 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end T3a_ps;

      function T3b_ps "Region 3 b: inverse function T(p,s)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "specific entropy";
          output SI.Temp_K T "Temperature";
      protected
          constant Real[:] n=
            {0.527111701601660,-0.401317830052742e2,0.153020073134484e3,-0.224799398218827e4,
             -0.193993484669048,-0.140467557893768e1,0.426799878114024e2,0.752810643416743,0.226657238616417e2,
             -0.622873556909932e3,-0.660823667935396,0.841267087271658,-0.253717501764397e2,0.485708963532948e3,
             0.880531517490555e3,0.265015592794626e7,-0.359287150025783,-0.656991567673753e3,0.241768149185367e1,
             0.856873461222588,0.655143675313458,-0.213535213206406,0.562974957606348e-2,-0.316955725450471e15,
             -0.699997000152457e-3,0.119845803210767e-1,0.193848122022095e-4,-0.215095749182309e-4};
          constant Real[:] I = {-12,-12,-12,-12,-8,-8,-8,-6,-6,-6,-5,-5,-5,-5,-5,-4,-3,-3,-2,0,2,3,4,5,6,8,12,14};
          constant Real[:] J = {1,3,4,7,0,1,3,0,2,4,0,1,2,4,6,12,1,6,2,0,1,1,0,24,0,3,1,2};
          constant SI.Temp_K Tstar = 860 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEntropy sstar = 5.3e3 "normalization entropy";
          Real pi = p/pstar "normalized specific pressure";
          Real sigma = s/sstar "normalized specific entropy";
      algorithm
          T := sum(n[i]*(pi + 0.760)^I[i]*(sigma - 0.818)^J[i] for i in 1:28)*Tstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 7 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end T3b_ps;

      function v3a_ps "Region 3 a: inverse function v(p,s)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "specific entropy";
          output SI.SpecificVolume v "specific volume";
      protected
          constant Real[:] n=
            {0.795544074093975e2,-0.238261242984590e4,0.176813100617787e5,-0.110524727080379e-2,
             -0.153213833655326e2,0.297544599376982e3,-0.350315206871242e8,0.277513761062119,-0.523964271036888,
             -0.148011182995403e6,0.160014899374266e7,0.170802322663427e13,0.246866996006494e-3,0.165326084797980e1,
             -0.118008384666987,0.253798642355900e1,0.965127704669424,-0.282172420532826e2,0.203224612353823,
             0.110648186063513e1,0.526127948451280,0.277000018736321,0.108153340501132e1,-0.744127885357893e-1,
             0.164094443541384e-1,-0.680468275301065e-1,0.257988576101640e-1,-0.145749861944416e-3};
          constant Real[:] I = {-12,-12,-12,-10,-10,-10,-10,-8,-8,-8,-8,-6,-5,-4,-3,-3,-2,-2,-1,-1,0,0,0,1,2,4,5,6};
          constant Real[:] J = {10,12,14,4,8,10,20,5,6,14,16,28,1,5,2,4,3,8,1,2,0,1,3,0,0,2,2,0};
          constant SI.Volume vstar = 0.0028 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEntropy sstar = 4.4e3 "normalization entropy";
          Real pi = p/pstar "normalized specific pressure";
          Real sigma = s/sstar "normalized specific entropy";
      algorithm
          v := sum(n[i]*(pi + 0.187)^I[i]*(sigma - 0.755)^J[i] for i in 1:28)*vstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 8 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end v3a_ps;

      function v3b_ps "Region 3 b: inverse function v(p,s)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "specific entropy";
          output SI.SpecificVolume v "specific volume";
      protected
          constant Real[:] n=
            {0.591599780322238e-4,-0.185465997137856e-2,0.104190510480013e-1,0.598647302038590e-2,
             -0.771391189901699,0.172549765557036e1,-0.467076079846526e-3,0.134533823384439e-1,-0.808094336805495e-1,
             0.508139374365767,0.128584643361683e-2,-0.163899353915435e1,0.586938199318063e1,-0.292466667918613e1,
             -0.614076301499537e-2,0.576199014049172e1,-0.121613320606788e2,0.167637540957944e1,-0.744135838773463e1,
             0.378168091437659e-1,0.401432203027688e1,0.160279837479185e2,0.317848779347728e1,-0.358362310304853e1,
             -0.115995260446827e7,0.199256573577909,-0.122270624794624,-0.191449143716586e2,-0.150448002905284e-1,
             0.146407900162154e2,-0.327477787188230e1};
          constant Real[:] I = {-12,-12,-12,-12,-12,-12,-10,-10,
                                -10,-10,-8,-5,-5,-5,-4,-4,-4,-4,-3,-2,-2,-2,-2,-2,-2,0,0,0,1,1,2};
          constant Real[:] J = {0,1,2,3,5,6,0,1,2,4,0,1,2,3,0,1,2,3,1,0,1,2,3,4,12,0,1,2,0,2,2};
          constant SI.Volume vstar = 0.0088 "normalization temperature";
          constant SI.Pressure pstar = 100e6 "normalization pressure";
          constant SI.SpecificEntropy sstar = 5.3e3 "normalization entropy";
          Real pi = p/pstar "normalized specific pressure";
          Real sigma = s/sstar "normalized specific entropy";
      algorithm
          v := sum(n[i]*(pi + 0.298)^I[i]*(sigma - 0.816)^J[i] for i in 1:31)*vstar;
          annotation (
            Documentation(
       info="<html>
 <p>
 &nbsp;Equation number 9 from:<br>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Fucnctions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</p>
 </html>"));
      end v3b_ps;

      annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package BaseIF97/Basic computes the the fundamental functions for the 5 regions of the steam tables
          as described in the standards document <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a>. The code of these
          functions has been generated using <b><i>Mathematica</i></b> and the add-on packages \"Format\" and \"Optimize\"
          to generate highly efficient, expression-optimized C-code from a symbolic representation of the thermodynamic
          functions. The C-code has than been transformed into Modelica code. An important feature of this optimization was to
          simultaneously optimize the functions and the directional derivatives because they share many common subexpressions.</p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>g1</b> computes the dimensionless Gibbs function for region 1 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>g2</b> computes the dimensionless Gibbs function  for region 2 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>g2metastable</b> computes the dimensionless Gibbs function for metastable vapour
          (adjacent to region 2 but 2-phase at equilibrium) and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>f3</b> computes the dimensionless Helmholtz function  for region 3 and all derivatives up
          to order 2 w.r.t. delta and tau. Inputs: d and T.</li>
          <li>Function <b>g5</b>computes the dimensionless Gibbs function for region 5 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>tph1</b> computes the inverse function T(p,h) in region 1.</li>
          <li>Function <b>tph2</b> computes the inverse function T(p,h) in region 2.</li>
          <li>Function <b>tps2a</b> computes the inverse function T(p,s) in region 2a.</li>
          <li>Function <b>tps2b</b> computes the inverse function T(p,s) in region 2b.</li>
          <li>Function <b>tps2c</b> computes the inverse function T(p,s) in region 2c.</li>
          <li>Function <b>tps2</b> computes the inverse function T(p,s) in region 2.</li>
          <li>Function <b>tsat</b> computes the saturation temperature as a function of pressure.</li>
          <li>Function <b>dtsatofp</b> computes the derivative of the saturation temperature w.r.t. pressure as
          a function of pressure.</li>
          <li>Function <b>tsat_der</b> computes the Modelica derivative function of tsat.</li>
          <li>Function <b>psat</b> computes the saturation pressure as a function of temperature.</li>
          <li>Function <b>dptofT</b>  computes the derivative of the saturation pressure w.r.t. temperature as
          a function of temperature.</li>
          <li>Function <b>psat_der</b> computes the Modelica derivative function of psat.</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documentation added: December 2002</li>
          </ul>
          </HTML>
          "),     Documentation(
       info="<html>
       <p>
       &nbsp;Equation from:<br>
       <div style=\"text-align: center;\">&nbsp;[1] The international Association
       for the Properties of Water and Steam<br>
       &nbsp;Vejle, Denmark<br>
       &nbsp;August 2003<br>
       &nbsp;Supplementary Release on Backward Equations for the Fucnctions
       T(p,h), v(p,h) and T(p,s), <br>
       &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
       the Thermodynamic Properties of<br>
       &nbsp;Water and Steam</div>
    </p>
       </html>"));
    end Basic;

  package IceBoundaries
      "the melting line and sublimation line curves from IAPWS"
    extends Modelica.Icons.Package;
      function pmIceI_T
        "Melting pressure of ice I (temperature range from 273.16 to 251.165 K)"
        extends Modelica.Icons.Function;
        input SI.Temp_K T "Temperature";
        output SI.Pressure pm
          "Melting pressure of iceI(for T from 273.16 to 251.165 K)";
      protected
        constant SI.Temp_K Tn = 273.16 "normalization temperature";
        constant SI.Pressure pn = 611.657 "normalization pressure";
        Real sigma = T/Tn "normalized temperature";
      algorithm
        pm := (1-0.626000e6*(1-sigma^(-3)) + 0.197135e6*(1-sigma^(21.2)))*pn;
        annotation (
            Documentation(                                                                                                    info="<html>
  <p>
  Equation 1 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
      end pmIceI_T;

      function pmIceIII_T
        "Melting pressure of ice III (temperature range from 251.165 to 256.164 K)"
        extends Modelica.Icons.Function;
        input SI.Temp_K T "Temperature";
        output SI.Pressure pm
          "Melting pressure of iceIII(for T from 251.165 to 256.164 K)";
      protected
        constant SI.Temp_K Tn = 251.165 "normalization temperature";
        constant SI.Pressure pn = 209.9e6 "normalization pressure";
        Real sigma = T/Tn "normalized temperature";
      algorithm
        pm := (1-0.295252*(1-sigma^60))*pn;
        annotation (
            Documentation(                                                                                                    info="<html>
  <p>
  Equation 2 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
      end pmIceIII_T;

      function pmIceV_T
        "Melting pressure of ice V (temperature range from 256.164 to 273.31 K)"
        extends Modelica.Icons.Function;
        input SI.Temp_K T "Temperature";
        output SI.Pressure pm
          "Melting pressure of iceV(for T from 256.164 to 273.31 K)";
      protected
        constant SI.Temp_K Tn = 256.164 "normalization temperature";
        constant SI.Pressure pn = 350.1e6 "normalization pressure";
        Real sigma = T/Tn "normalized temperature";

      algorithm
        pm := (1-1.18721*(1-sigma^8))*pn;
        annotation (
            Documentation(                                                                                                    info="<html>
  <p>
  Equation 3 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
      end pmIceV_T;

      function sublimationPressure_T
        "Sublimation pressure, valid from 190 to 273.16 K"
        extends Modelica.Icons.Function;
        input SI.Temp_K T "Temperature";
        output SI.Pressure psubl
          "sublimation pressure (for T from 190 to 273.16)";
      protected
        constant SI.Temp_K Tn = 273.16 "normalization temperature";
        constant SI.Pressure pn = 611.657 "normalization pressure";
        constant Real[2] a = {-13.9281690,34.7078238} "constant values";
        Real sigma = T/Tn "normalized temperature";
      algorithm
        psubl := Modelica.Math.exp(a[1]*(1-sigma^(-1.5)) + a[2]*(1-sigma^(-1.25)))*pn;
        annotation (
            Documentation(                                                                                                    info="<html>
  <p>
  Equation 6 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
      end sublimationPressure_T;

      annotation (Documentation(info="<html>
<p>
The International Association for the Properties of Water and Steam<br>
Milan, Italy<br>
September 1993<br>
Release on the Pressure along the Melting and the Sublimation Curves of
Ordinary Water Substance<br>
</p>
</html>
"));
  end IceBoundaries;

    package Transport "transport properties for water according to IAPWS/IF97"

       extends Modelica.Icons.Package;

      function visc_dTp "dynamic viscosity eta(d,T,p), industrial formulation"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        input SI.Pressure p "pressure (only needed for region of validity)";
        input Integer phase=0
          "2 for two-phase, 1 for one-phase, 0 if not known";
        output SI.DynamicViscosity eta "dynamic viscosity";
      protected
        constant Real n0=1.0 "viscosity coefficient";
        constant Real n1=0.978197 "viscosity coefficient";
        constant Real n2=0.579829 "viscosity coefficient";
        constant Real n3=-0.202354 "viscosity coefficient";
        constant Real[42] nn=array(.5132047, 0.3205656, 0.0, 0.0, -0.7782567,
            0.1885447, 0.2151778, 0.7317883, 1.241044, 1.476783, 0.0, 0.0, -0.2818107,
             -1.070786, -1.263184, 0.0, 0.0, 0.0, 0.1778064, 0.460504,
            0.2340379, -0.4924179, 0.0, 0.0, -0.0417661, 0.0, 0.0, 0.1600435,
            0.0, 0.0, 0.0, -0.01578386, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.003629481,
             0.0, 0.0) "viscosity coefficients";
        constant SI.Density rhostar=317.763 "scaling density";
        constant SI.DynamicViscosity etastar=55.071e-6 "scaling viscosity";
        constant SI.Temperature tstar=647.226 "scaling temperature";
        Integer i "auxiliary variable";
        Integer j "auxiliary variable";
        Real delta "dimensionless density";
        Real deltam1 "dimensionless density";
        Real tau "dimensionless temperature";
        Real taum1 "dimensionless temperature";
        Real Psi0 "auxiliary variable";
        Real Psi1 "auxiliary variable";
        Real tfun "auxiliary variable";
        Real rhofun "auxiliary variable";
        Real Tc=T - 273.15 "Celsius temperature for region check";
        //      Integer region "region of IF97";
      algorithm
        //      if phase == 0 then
        //        region := BaseIF97.Regions.region_dT(d,T,0);
        //      end if;
        //      if phase == 2 then
        //        region := 4;
        //      end if;
        // assert(phase <> 2, "viscosity can not be computed for two-phase states");
        delta := d/rhostar;
        assert(d > triple.dvtriple,
          "IF97 medium function visc_dTp for viscosity called with too low density\n" +
          "d = " + String(d) + " <= " + String(triple.dvtriple) + " (triple point density)");
        assert((p <= 500e6 and (Tc >= 0.0 and Tc <= 150)) or (p <= 350e6 and (
          Tc > 150.0 and Tc <= 600)) or (p <= 300e6 and (Tc > 600.0 and Tc <=
          900)),
          "IF97 medium function visc_dTp: viscosity computed outside the range\n" +
          "of validity of the IF97 formulation: p = " + String(p) + " Pa, Tc = " + String(Tc) + " K");
        deltam1 := delta - 1.0;
        tau := tstar/T;
        taum1 := tau - 1.0;
        Psi0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
        Psi1 := 0.0;
        tfun := 1.0;
        for i in 1:6 loop
          if (i <> 1) then
            tfun := tfun*taum1;
          end if;
          rhofun := 1.;
          for j in 0:6 loop
            if (j <> 0) then
              rhofun := rhofun*deltam1;
            end if;
            Psi1 := Psi1 + nn[i + j*6]*tfun*rhofun;
          end for;
        end for;
        eta := etastar*Psi0*Modelica.Math.exp(delta*Psi1);
      end visc_dTp;

      function cond_dTp
        "Thermal conductivity lam(d,T,p) (industrial use version) only in one-phase region"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        input SI.Pressure p "pressure";
        input Integer phase=0
          "2 for two-phase, 1 for one-phase, 0 if not known";
        input Boolean industrialMethod=true
          "if true, the industrial method is used, otherwise the scientific one";
        output SI.ThermalConductivity lambda "thermal conductivity";
      protected
        Integer region(min=1, max=5) "IF97 region, valid values:1,2,3, and 5";
        constant Real n0=1.0 "conductivity coefficient";
        constant Real n1=6.978267 "conductivity coefficient";
        constant Real n2=2.599096 "conductivity coefficient";
        constant Real n3=-0.998254 "conductivity coefficient";
        constant Real[30] nn=array(1.3293046, 1.7018363, 5.2246158, 8.7127675,
            -1.8525999, -0.40452437, -2.2156845, -10.124111, -9.5000611,
            0.9340469, 0.2440949, 1.6511057, 4.9874687, 4.3786606, 0.0,
            0.018660751, -0.76736002, -0.27297694, -0.91783782, 0.0, -0.12961068,
             0.37283344, -0.43083393, 0.0, 0.0, 0.044809953, -0.1120316,
            0.13333849, 0.0, 0.0) "conductivity coefficient";
        constant SI.ThermalConductivity lamstar=0.4945 "scaling conductivity";
        constant SI.Density rhostar=317.763 "scaling density";
        constant SI.Temperature tstar=647.226 "scaling temperature";
        constant SI.Pressure pstar=22.115e6 "scaling pressure";
        constant SI.DynamicViscosity etastar=55.071e-6 "scaling viscosity";
        Integer i "auxiliary variable";
        Integer j "auxiliary variable";
        Real delta "dimensionless density";
        Real tau "dimensionless temperature";
        Real deltam1 "dimensionless density";
        Real taum1 "dimensionless temperature";
        Real Lam0 "part of thermal conductivity";
        Real Lam1 "part of thermal conductivity";
        Real Lam2 "part of thermal conductivity";
        Real tfun "auxiliary variable";
        Real rhofun "auxiliary variable";
        Real dpitau "auxiliary variable";
        Real ddelpi "auxiliary variable";
        Real d2 "auxiliary variable";
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Real Tc=T - 273.15 "Celsius temperature for region check";
        Real Chi "symmetrized compressibility";
        // slightly different variables for industrial use
        constant SI.Density rhostar2=317.7 "Reference density";
        constant SI.Temperature Tstar2=647.25 "Reference temperature";
        constant SI.ThermalConductivity lambdastar=1
          "Reference thermal conductivity";
        parameter Real TREL=T/Tstar2 "Relative temperature";
        parameter Real rhoREL=d/rhostar2 "Relative density";
        Real lambdaREL "Relative thermal conductivity";
        Real deltaTREL "Relative temperature increment";
        constant Real[:] C={0.642857,-4.11717,-6.17937,0.00308976,0.0822994,
            10.0932};
        constant Real[:] dpar={0.0701309,0.0118520,0.00169937,-1.0200};
        constant Real[:] b={-0.397070,0.400302,1.060000};
        constant Real[:] B={-0.171587,2.392190};
        constant Real[:] a={0.0102811,0.0299621,0.0156146,-0.00422464};
        Real Q;
        Real S;
        Real lambdaREL2
          "function, part of the interpolating equation of the thermal conductivity";
        Real lambdaREL1
          "function, part of the interpolating equation of the thermal conductivity";
        Real lambdaREL0
          "function, part of the interpolating equation of the thermal conductivity";
      algorithm
        // region := BaseIF97.Regions.region_dT(d,T,phase);
        // simplified region check, assuming that calling arguments are legal
        //  assert(phase <> 2,
        //   "thermalConductivity can not be called with 2-phase inputs!");
        assert(d > triple.dvtriple,
          "IF97 medium function cond_dTp called with too low density\n" +
          "d = " + String(d) + " <= " + String(triple.dvtriple) + " (triple point density)");
        assert((p <= 100e6 and (Tc >= 0.0 and Tc <= 500)) or
        (p <= 70e6 and (Tc > 500.0 and Tc <= 650)) or
        (p <= 40e6 and (Tc > 650.0 and Tc <= 800)),
        "IF97 medium function cond_dTp: thermal conductivity computed outside the range\n" +
        "of validity of the IF97 formulation: p = " + String(p) + " Pa, Tc = " + String(Tc) + " K");
        if industrialMethod == true then
          deltaTREL := abs(TREL - 1) + C[4];
          Q := 2 + C[5]/deltaTREL^(3/5);
          if TREL >= 1 then
            S := 1/deltaTREL;
          else
            S := C[6]/deltaTREL^(3/5);
          end if;
          lambdaREL2 := (dpar[1]/TREL^10 + dpar[2])*rhoREL^(9/5)*Modelica.Math.exp(C[1]*(1 - rhoREL^(14
            /5))) + dpar[3]*S*rhoREL^Q*Modelica.Math.exp((Q/(1 + Q))*(1 -
            rhoREL^(1 + Q))) + dpar[4]*Modelica.Math.exp(C[2]*TREL^(3/2) + C[3]
            /rhoREL^5);
          lambdaREL1 := b[1] + b[2]*rhoREL + b[3]*Modelica.Math.exp(B[1]*(
            rhoREL + B[2])^2);
          lambdaREL0 := TREL^(1/2)*sum(a[i]*TREL^(i - 1) for i in 1:4);
          lambdaREL := lambdaREL0 + lambdaREL1 + lambdaREL2;
          lambda := lambdaREL*lambdastar;
        else
          if p < data.PLIMIT4A then
            //regions are 1 or 2,
            if d > data.DCRIT then
       region := 1;
            else
       region := 2;
            end if;
          else
            //region is 3, or illegal
            assert(false,
              "the scientific method works only for temperature up to 623.15 K");
          end if;
          tau := tstar/T;
          delta := d/rhostar;
          deltam1 := delta - 1.0;
          taum1 := tau - 1.0;
          Lam0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
          Lam1 := 0.0;
          tfun := 1.0;
          for
       i in 1:5 loop
            if (i <> 1) then
       tfun := tfun*taum1;
            end if;
            rhofun := 1.0;
            for
         j in 0:5 loop
       if (j <> 0) then
                rhofun := rhofun*deltam1;
       end if;
       Lam1 := Lam1 + nn[i + j*5]*tfun*rhofun;
            end for;
          end for;
          if (region == 1) then
            g := Basic.g1(p, T);
            // dp/dT @ cont d = -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
            dpitau := -tstar/pstar*(data.PSTAR1*(g.gpi - data.TSTAR1/T*g.gtaupi)
              /g.gpipi/T);
            ddelpi := -pstar/rhostar*data.RH2O/data.PSTAR1/data.PSTAR1*T*d*d*g.
              gpipi;
            Chi := delta*ddelpi;
          elseif (region == 2) then
            g := Basic.g2(p, T);
            dpitau := -tstar/pstar*(data.PSTAR2*(g.gpi - data.TSTAR2/T*g.gtaupi)
              /g.gpipi/T);
            ddelpi := -pstar/rhostar*data.RH2O/data.PSTAR2/data.PSTAR2*T*d*d*g.
              gpipi;
            Chi := delta*ddelpi;
            //         elseif (region == 3) then
            //           f := Basic.f3(T, d);
            //            dpitau := tstar/pstar*(f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau));
            //           ddelpi := pstar*d*d/(rhostar*p*p)/(f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta));
            //    Chi := delta*ddelpi;
          else
            assert(false,
              "thermal conductivity can only be called in the one-phase regions below 623.15 K\n" +
              "(p = " + String(p) + " Pa, T = " + String(T) + " K, region = " + String(region) + ")");
          end if;
          taum1 := 1/tau - 1;
          d2 := deltam1*deltam1;
          Lam2 := 0.0013848*etastar/visc_dTp(d, T, p)/(tau*tau*delta*delta)*
            dpitau*dpitau*max(Chi, Modelica.Constants.small)^0.4678*(delta)^0.5
            *Modelica.Math.exp(-18.66*taum1*taum1 - d2*d2);
          lambda := lamstar*(Lam0*Modelica.Math.exp(delta*Lam1) + Lam2);
        end if;
      end cond_dTp;

      function surfaceTension
        "surface tension in region 4 between steam and water"
        extends Modelica.Icons.Function;
        input SI.Temperature T "temperature (K)";
        output SI.SurfaceTension sigma "surface tension in SI units";
      protected
        Real Theta "dimensionless temperature";
      algorithm
        Theta := min(1.0,T/data.TCRIT);
        sigma := 235.8e-3*(1 - Theta)^1.256*(1 - 0.625*(1 - Theta));
      end surfaceTension;

      annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p></p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>visc_dTp</b> implements a function to compute the industrial formulation of the
          dynamic viscosity of water as a function of density and temperature.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/visc.pdf\">visc.pdf</a>.</li>
          <li>Function <b>cond_dTp</b> implements a function to compute  the industrial formulation of the thermal conductivity of water as
          a function of density, temperature and pressure. <b>Important note</b>: Obviously only two of the three
          inputs are really needed, but using three inputs speeds up the computation and the three variables are known in most models anyways.
          The inputs d,T and p have to be consistent.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/surf.pdf\">surf.pdf</a>.</li>
          <li>Function <b>surfaceTension</b> implements a function to compute the surface tension between vapour
          and liquid water as a function of temperature.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/thcond.pdf\">thcond.pdf</a>.</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>October, 2002</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Authors: Hubertus Tummescheit and Jonas Eborn<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: October 2002</li>
          </ul>
          </HTML>
          "));
    end Transport;

    package Isentropic
      "functions for calculating the isentropic enthalpy from pressure p and specific entropy s"

      extends Modelica.Icons.Package;

      function hofpT1
        "intermediate function for isentropic specific enthalpy in region 1"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real[13] o "vector of auxiliary variables";
        Real pi1 "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau1 "dimensionless temperature";
      algorithm
        tau := data.TSTAR1/T;
        pi1 := 7.1 - p/data.PSTAR1;
        assert(p > triple.ptriple,
          "IF97 medium function hofpT1  called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        tau1 := -1.222 + tau;
        o[1] := tau1*tau1;
        o[2] := o[1]*tau1;
        o[3] := o[1]*o[1];
        o[4] := o[3]*o[3];
        o[5] := o[1]*o[4];
        o[6] := o[1]*o[3];
        o[7] := o[3]*tau1;
        o[8] := o[3]*o[4];
        o[9] := pi1*pi1;
        o[10] := o[9]*o[9];
        o[11] := o[10]*o[10];
        o[12] := o[4]*o[4];
        o[13] := o[12]*o[12];

        h := data.RH2O*T*tau*(pi1*((-0.00254871721114236 + o[1]*(
          0.00424944110961118 + (0.018990068218419 + (-0.021841717175414 -
          0.00015851507390979*o[1])*o[1])*o[6]))/o[5] + pi1*((
          0.00141552963219801 + o[3]*(0.000047661393906987 + o[1]*(-0.0000132425535992538
           - 1.2358149370591e-14*o[1]*o[3]*o[4])))/o[3] + pi1*((
          0.000126718579380216 - 5.11230768720618e-9*o[5])/o[7] + pi1*((
          0.000011212640954 + o[2]*(1.30342445791202e-6 - 1.4341729937924e-12*o[
          8]))/o[6] + pi1*(o[9]*pi1*((1.40077319158051e-8 + 1.04549227383804e-9
          *o[7])/o[8] + o[10]*o[11]*pi1*(1.9941018075704e-17/(o[1]*o[12]*o[3]*o[
          4]) + o[9]*(-4.48827542684151e-19/o[13] + o[10]*o[9]*(pi1*(
          4.65957282962769e-22/(o[13]*o[4]) + pi1*((3.83502057899078e-24*pi1)/(
          o[1]*o[13]*o[4]) - 7.2912378325616e-23/(o[13]*o[4]*tau1))) -
          1.00075970318621e-21/(o[1]*o[13]*o[3]*tau1))))) + 3.24135974880936e-6
          /(o[4]*tau1)))))) + (-0.29265942426334 + tau1*(0.84548187169114 + o[1]
          *(3.3855169168385 + tau1*(-1.91583926775744 + tau1*(0.47316115539684
           + (-0.066465668798004 + 0.0040607314991784*tau1)*tau1)))))/o[2]);
      end hofpT1;

      function handsofpT1
        "special function for specific enthalpy and specific entropy in region 1"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.SpecificEnthalpy h "specific enthalpy";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real[28] o "vector of auxiliary variables";
        Real pi1 "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau1 "dimensionless temperature";
        Real g "dimensionless Gibbs energy";
        Real gtau "derivative of  dimensionless Gibbs energy w.r.t. tau";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function handsofpT1 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        tau := data.TSTAR1/T;
        pi1 := 7.1 - p/data.PSTAR1;
        tau1 := -1.222 + tau;
        o[1] := tau1*tau1;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*tau1;
        o[5] := 1/o[4];
        o[6] := o[1]*o[2];
        o[7] := o[1]*tau1;
        o[8] := 1/o[7];
        o[9] := o[1]*o[2]*o[3];
        o[10] := 1/o[2];
        o[11] := o[2]*tau1;
        o[12] := 1/o[11];
        o[13] := o[2]*o[3];
        o[14] := pi1*pi1;
        o[15] := o[14]*pi1;
        o[16] := o[14]*o[14];
        o[17] := o[16]*o[16];
        o[18] := o[16]*o[17]*pi1;
        o[19] := o[14]*o[16];
        o[20] := o[3]*o[3];
        o[21] := o[20]*o[20];
        o[22] := o[21]*o[3]*tau1;
        o[23] := 1/o[22];
        o[24] := o[21]*o[3];
        o[25] := 1/o[24];
        o[26] := o[1]*o[2]*o[21]*tau1;
        o[27] := 1/o[26];
        o[28] := o[1]*o[3];

        g := pi1*(pi1*(pi1*(o[10]*(-0.000031679644845054 + o[2]*(-2.8270797985312e-6
           - 8.5205128120103e-10*o[6])) + pi1*(o[12]*(-2.2425281908e-6 + (-6.5171222895601e-7
           - 1.4341729937924e-13*o[13])*o[7]) + pi1*(-4.0516996860117e-7/o[3]
           + o[15]*(o[18]*(o[14]*(o[19]*(2.6335781662795e-23/(o[1]*o[2]*o[21])
           + pi1*(-1.1947622640071e-23*o[27] + pi1*(1.8228094581404e-24*o[25]
           - 9.3537087292458e-26*o[23]*pi1))) + 1.4478307828521e-20/(o[1]*o[2]*
          o[20]*o[3]*tau1)) - 6.8762131295531e-19/(o[2]*o[20]*o[3]*tau1)) + (-1.2734301741641e-9
           - 1.7424871230634e-10*o[11])/(o[1]*o[3]*tau1))))) + o[8]*(-0.00047184321073267
           + o[7]*(-0.00030001780793026 + (0.000047661393906987 + o[1]*(-4.4141845330846e-6
           - 7.2694996297594e-16*o[9]))*tau1))) + o[5]*(0.00028319080123804 + o[
          1]*(-0.00060706301565874 + o[6]*(-0.018990068218419 + tau1*(-0.032529748770505
           + (-0.021841717175414 - 0.00005283835796993*o[1])*tau1))))) + (
          0.14632971213167 + tau1*(-0.84548187169114 + tau1*(-3.756360367204 +
          tau1*(3.3855169168385 + tau1*(-0.95791963387872 + tau1*(
          0.15772038513228 + (-0.016616417199501 + 0.00081214629983568*tau1)*
          tau1))))))/o[1];

        gtau := pi1*((-0.00254871721114236 + o[1]*(0.00424944110961118 + (
          0.018990068218419 + (-0.021841717175414 - 0.00015851507390979*o[1])*o[
          1])*o[6]))/o[28] + pi1*(o[10]*(0.00141552963219801 + o[2]*(
          0.000047661393906987 + o[1]*(-0.0000132425535992538 -
          1.2358149370591e-14*o[9]))) + pi1*(o[12]*(0.000126718579380216 -
          5.11230768720618e-9*o[28]) + pi1*((0.000011212640954 + (
          1.30342445791202e-6 - 1.4341729937924e-12*o[13])*o[7])/o[6] + pi1*(
          3.24135974880936e-6*o[5] + o[15]*((1.40077319158051e-8 +
          1.04549227383804e-9*o[11])/o[13] + o[18]*(1.9941018075704e-17/(o[1]*o[
          2]*o[20]*o[3]) + o[14]*(-4.48827542684151e-19/o[21] + o[19]*(-1.00075970318621e-21
          *o[27] + pi1*(4.65957282962769e-22*o[25] + pi1*(-7.2912378325616e-23*
          o[23] + (3.83502057899078e-24*pi1)/(o[1]*o[21]*o[3])))))))))))) + o[8]
          *(-0.29265942426334 + tau1*(0.84548187169114 + o[1]*(3.3855169168385
           + tau1*(-1.91583926775744 + tau1*(0.47316115539684 + (-0.066465668798004
           + 0.0040607314991784*tau1)*tau1)))));

        h := data.RH2O*T*tau*gtau;
        s := data.RH2O*(tau*gtau - g);
      end handsofpT1;

      function hofps1 "function for isentropic specific enthalpy in region 1"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        SI.Temperature T "temperature (K)";
      algorithm
        T := Basic.tps1(p, s);
        h := hofpT1(p, T);
      end hofps1;

      // for isentropic specific enthalpy get T(p,s), then use this
      function hofpT2
        "intermediate function for isentropic specific enthalpy in region 2"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real[16] o "vector of auxiliary variables";
        Real pi "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau2 "dimensionless temperature";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function hofpT2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        pi := p/data.PSTAR2;
        tau := data.TSTAR2/T;
        tau2 := -0.5 + tau;
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := tau2*tau2;
        o[4] := o[3]*tau2;
        o[5] := o[3]*o[3];
        o[6] := o[5]*o[5];
        o[7] := o[6]*o[6];
        o[8] := o[5]*o[6]*o[7]*tau2;
        o[9] := o[3]*o[5];
        o[10] := o[5]*o[6]*tau2;
        o[11] := o[3]*o[7]*tau2;
        o[12] := o[3]*o[5]*o[6];
        o[13] := o[5]*o[6]*o[7];
        o[14] := pi*pi;
        o[15] := o[14]*o[14];
        o[16] := o[7]*o[7];

        h := data.RH2O*T*tau*((0.0280439559151 + tau*(-0.2858109552582 + tau*(
          1.2213149471784 + tau*(-2.848163942888 + tau*(4.38395111945 + o[1]*(
          10.08665568018 + (-0.5681726521544 + 0.06380539059921*tau)*tau))))))/
          (o[1]*o[2]) + pi*(-0.017834862292358 + tau2*(-0.09199202739273 + (-0.172743777250296
           - 0.30195167236758*o[4])*tau2) + pi*(-0.000033032641670203 + (-0.0003789797503263
           + o[3]*(-0.015757110897342 + o[4]*(-0.306581069554011 -
          0.000960283724907132*o[8])))*tau2 + pi*(4.3870667284435e-7 + o[3]*(-0.00009683303171571
           + o[4]*(-0.0090203547252888 - 1.42338887469272*o[8])) + pi*(-7.8847309559367e-10
           + (2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
          0.0000160454534363627*o[9] + pi*((-5.0144299353183e-11 + o[10]*(-0.033874355714168
           - 836.35096769364*o[11]))*o[3] + pi*((-0.0000138839897890111 -
          0.973671060893475*o[12])*o[3]*o[6] + pi*((9.0049690883672e-11 -
          296.320827232793*o[13])*o[3]*o[5]*tau2 + pi*(2.57526266427144e-7*o[5]
          *o[6] + pi*(o[4]*(4.1627860840696e-19 + (-1.0234747095929e-12 -
          1.40254511313154e-8*o[5])*o[9]) + o[14]*o[15]*(o[13]*(-2.34560435076256e-9
           + 5.3465159397045*o[5]*o[7]*tau2) + o[14]*(-19.1874828272775*o[16]*o[
          6]*o[7] + o[14]*(o[11]*(1.78371690710842e-23 + (1.07202609066812e-11
           - 0.000201611844951398*o[10])*o[3]*o[5]*o[6]*tau2) + pi*(-1.24017662339842e-24
          *o[5]*o[7] + pi*(0.000200482822351322*o[16]*o[5]*o[7] + pi*(-4.97975748452559e-14
          *o[16]*o[3]*o[5] + o[6]*o[7]*(1.90027787547159e-27 + o[12]*(
          2.21658861403112e-15 - 0.0000547344301999018*o[3]*o[7]))*pi*tau2)))))))))))))))));
      end hofpT2;

      function handsofpT2
        "function for isentropic specific enthalpy and specific entropy in region 2"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.SpecificEnthalpy h "specific enthalpy";
        output SI.SpecificEntropy s "specific entropy";
      protected
        Real[22] o "vector of auxiliary variables";
        Real pi "dimensionless pressure";
        Real tau "dimensionless temperature";
        Real tau2 "dimensionless temperature";
        Real g "dimensionless Gibbs energy";
        Real gtau "derivative of  dimensionless Gibbs energy w.r.t. tau";
      algorithm
        assert(p > triple.ptriple,
          "IF97 medium function handsofpT2 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        tau := data.TSTAR2/T;
        pi := p/data.PSTAR2;
        tau2 := tau - 0.5;
        o[1] := tau2*tau2;
        o[2] := o[1]*tau2;
        o[3] := o[1]*o[1];
        o[4] := o[3]*o[3];
        o[5] := o[4]*o[4];
        o[6] := o[3]*o[4]*o[5]*tau2;
        o[7] := o[1]*o[3]*tau2;
        o[8] := o[3]*o[4]*tau2;
        o[9] := o[1]*o[5]*tau2;
        o[10] := o[1]*o[3]*o[4];
        o[11] := o[3]*o[4]*o[5];
        o[12] := o[1]*o[3];
        o[13] := pi*pi;
        o[14] := o[13]*o[13];
        o[15] := o[13]*o[14];
        o[16] := o[3]*o[5]*tau2;
        o[17] := o[5]*o[5];
        o[18] := o[3]*o[5];
        o[19] := o[1]*o[3]*o[4]*tau2;
        o[20] := o[1]*o[5];
        o[21] := tau*tau;
        o[22] := o[21]*o[21];

        g := pi*(-0.0017731742473213 + tau2*(-0.017834862292358 + tau2*(-0.045996013696365
           + (-0.057581259083432 - 0.05032527872793*o[2])*tau2)) + pi*(tau2*(-0.000033032641670203
           + (-0.00018948987516315 + o[1]*(-0.0039392777243355 + o[2]*(-0.043797295650573
           - 0.000026674547914087*o[6])))*tau2) + pi*(2.0481737692309e-8 + (
          4.3870667284435e-7 + o[1]*(-0.00003227767723857 + o[2]*(-0.0015033924542148
           - 0.040668253562649*o[6])))*tau2 + pi*(tau2*(-7.8847309559367e-10 +
          (1.2790717852285e-8 + 4.8225372718507e-7*tau2)*tau2) + pi*(
          2.2922076337661e-6*o[7] + pi*(o[2]*(-1.6714766451061e-11 + o[8]*(-0.0021171472321355
           - 23.895741934104*o[9])) + pi*(-5.905956432427e-18 + o[1]*(-1.2621808899101e-6
           - 0.038946842435739*o[10])*o[4]*tau2 + pi*((1.1256211360459e-11 -
          8.2311340897998*o[11])*o[4] + pi*(1.9809712802088e-8*o[8] + pi*((
          1.0406965210174e-19 + o[12]*(-1.0234747095929e-13 -
          1.0018179379511e-9*o[3]))*o[3] + o[15]*((-8.0882908646985e-11 +
          0.10693031879409*o[16])*o[6] + o[13]*(-0.33662250574171*o[17]*o[4]*o[
          5]*tau2 + o[13]*(o[18]*(8.9185845355421e-25 + o[19]*(
          3.0629316876232e-13 - 4.2002467698208e-6*o[8])) + pi*(-5.9056029685639e-26
          *o[16] + pi*(3.7826947613457e-6*o[17]*o[3]*o[5]*tau2 + pi*(o[1]*(
          7.3087610595061e-29 + o[10]*(5.5414715350778e-17 - 9.436970724121e-7*
          o[20]))*o[4]*o[5]*pi - 1.2768608934681e-15*o[1]*o[17]*o[3]*tau2))))))))))))))))
           + (-0.00560879118302 + tau*(0.07145273881455 + tau*(-0.4071049823928
           + tau*(1.424081971444 + tau*(-4.38395111945 + tau*(-9.692768600217
           + tau*(10.08665568018 + (-0.2840863260772 + 0.02126846353307*tau)*
          tau) + Modelica.Math.log(pi)))))))/(o[22]*tau);

        gtau := (0.0280439559151 + tau*(-0.2858109552582 + tau*(1.2213149471784
           + tau*(-2.848163942888 + tau*(4.38395111945 + o[21]*(10.08665568018
           + (-0.5681726521544 + 0.06380539059921*tau)*tau))))))/(o[21]*o[22])
           + pi*(-0.017834862292358 + tau2*(-0.09199202739273 + (-0.172743777250296
           - 0.30195167236758*o[2])*tau2) + pi*(-0.000033032641670203 + (-0.0003789797503263
           + o[1]*(-0.015757110897342 + o[2]*(-0.306581069554011 -
          0.000960283724907132*o[6])))*tau2 + pi*(4.3870667284435e-7 + o[1]*(-0.00009683303171571
           + o[2]*(-0.0090203547252888 - 1.42338887469272*o[6])) + pi*(-7.8847309559367e-10
           + (2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
          0.0000160454534363627*o[12] + pi*(o[1]*(-5.0144299353183e-11 + o[8]*(
          -0.033874355714168 - 836.35096769364*o[9])) + pi*(o[1]*(-0.0000138839897890111
           - 0.973671060893475*o[10])*o[4] + pi*((9.0049690883672e-11 -
          296.320827232793*o[11])*o[7] + pi*(2.57526266427144e-7*o[3]*o[4] + pi
          *(o[2]*(4.1627860840696e-19 + o[12]*(-1.0234747095929e-12 -
          1.40254511313154e-8*o[3])) + o[15]*(o[11]*(-2.34560435076256e-9 +
          5.3465159397045*o[16]) + o[13]*(-19.1874828272775*o[17]*o[4]*o[5] + o[
          13]*((1.78371690710842e-23 + o[19]*(1.07202609066812e-11 -
          0.000201611844951398*o[8]))*o[9] + pi*(-1.24017662339842e-24*o[18] +
          pi*(0.000200482822351322*o[17]*o[3]*o[5] + pi*(-4.97975748452559e-14*
          o[1]*o[17]*o[3] + (1.90027787547159e-27 + o[10]*(2.21658861403112e-15
           - 0.0000547344301999018*o[20]))*o[4]*o[5]*pi*tau2))))))))))))))));

        h := data.RH2O*T*tau*gtau;
        s := data.RH2O*(tau*gtau - g);
      end handsofpT2;

      function hofps2 "function for isentropic specific enthalpy in region 2"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        SI.Temperature T "temperature (K)";
      algorithm
        T := Basic.tps2(p, s);
        h := hofpT2(p, T);
      end hofps2;
      // region 3 extra functions

      // for isentropic specific enthalpy get (d,T) = f(p,s), then use this
      // which needs a bloody iteration, ...
      // this is one thing that needs to be done somehow, ...

      function hofdT3 "function for isentropic specific enthalpy in region 3"

        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real delta;
        Real tau "dimensionless temperature";
        Real[13] o "vector of auxiliary variables";
        Real ftau "derivative of  dimensionless Helmholtz energy w.r.t. tau";
        Real fdelta
          "derivative of  dimensionless Helmholtz energy w.r.t. delta";
      algorithm
        tau := data.TCRIT/T;
        delta := d/data.DCRIT;
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        o[4] := o[3]*tau;
        o[5] := o[1]*o[2]*o[3]*tau;
        o[6] := o[2]*o[3];
        o[7] := o[1]*o[3];
        o[8] := o[3]*o[3];
        o[9] := o[1]*o[2]*o[8];
        o[10] := o[1]*o[2]*o[8]*tau;
        o[11] := o[3]*o[8];
        o[12] := o[3]*o[8]*tau;
        o[13] := o[1]*o[3]*o[8];

        ftau := 20.944396974307 + tau*(-15.3735415757432 + o[2]*tau*(
          18.3301634515678 + o[1]*tau*(-28.08078114862 + o[1]*(14.4640436358204
           - 0.194503669468755*o[1]*o[3]*tau)))) + delta*((-2.5308630955428 + o[
          2]*(-6.9146446840086 + (13.2781565976477 - 10.9153200808732*o[1])*o[4]))
          *tau + delta*(tau*(-1.70429417648412 + o[2]*(29.3833689251262 + (-21.3518320798755
           + (0.867251811341388 + 3.26518619032008*o[2])*o[5])*tau)) + delta*((
          2.779959913892 + o[1]*(-8.075966009428 + o[6]*(-0.131436219478341 -
          12.37496929108*o[7])))*tau + delta*((-0.88952870857478 + o[1]*(
          3.62288282878932 + 18.3358370228714*o[9]))*tau + delta*(
          0.10770512626332 + o[1]*(-0.98740869776862 - 13.2264761307011*o[10])
           + delta*((0.188521503330184 + 4.27343239646986*o[11])*tau + delta*(-0.027006744482696
          *tau + delta*(-0.385692979164272*o[12] + delta*(delta*(-0.00016557679795037
           - 0.00116802137560719*delta*o[12]) + (0.00115845907256168 +
          0.0840031522296486*o[11])*tau)))))))));

        fdelta := (1.0658070028513 + delta*(o[1]*(-1.2654315477714 + o[2]*(-1.1524407806681
           + (0.88521043984318 - 0.64207765181607*o[1])*o[4])) + delta*(
          0.76986920373342 + o[1]*(-1.70429417648412 + o[2]*(9.7944563083754 +
          (-6.100523451393 + (0.078841073758308 + 0.25116816848616*o[2])*o[5])*
          tau)) + delta*(-0.8399798909613 + o[1]*(4.169939870838 + o[1]*(-6.056974507071
           + o[6]*(-0.0246442911521889 - 1.42788107204769*o[7]))) + delta*(
          0.175936297894 + o[1]*(-1.77905741714956 + o[1]*(3.62288282878932 +
          2.82089800351868*o[9])) + delta*(delta*(-0.133052405238576 + o[1]*(
          0.565564509990552 + 0.98617670687766*o[11]) + delta*(-0.094523605689436
          *o[1] + delta*(-0.118674762819776*o[13] + delta*(o[1]*(
          0.00521306582652756 + 0.0290780142333399*o[11]) + delta*(
          0.00080964802996215 - 0.000494162889679965*delta*o[13] -
          0.0016557679795037*tau))))) + (0.5385256313166 + o[1]*(-1.6456811629477
           - 2.5435531020579*o[10]))*tau))))))/delta;

        h := data.RH2O*T*(tau*ftau + delta*fdelta);
      end hofdT3;

      function hofps3 "isentropic specific enthalpy in region 3 h(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        SI.Density d "density";
        SI.Temperature T "temperature (K)";
        SI.Pressure delp=IterationData.DELP "iteration accuracy";
        SI.SpecificEntropy dels=IterationData.DELS "iteration accuracy";
        Integer error "error if not 0";
      algorithm
        (d,T,error) := Inverses.dtofps3(p=p,s= s,delp= delp,dels= dels);
        h := hofdT3(d, T);
      end hofps3;

      function hofpsdt3
        "isentropic specific enthalpy in region 3 h(p,s) with given good guess in d and T"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.Density dguess "good guess density, e.g., from adjacent volume";
        input SI.Temperature Tguess
          "good guess temperature, e.g., from adjacent volume";
        input SI.Pressure delp=IterationData.DELP "relative error in p";
        input SI.SpecificEntropy dels=IterationData.DELS "relative error in s";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        SI.Density d "density";
        SI.Temperature T "temperature (K)";
        Integer error "error flag";
      algorithm
        (d,T,error) := Inverses.dtofpsdt3(p=p,s= s,dguess= dguess,Tguess=
          Tguess,delp= delp,dels= dels);
        h := hofdT3(d, T);
      end hofpsdt3;

      function hofps4 "isentropic specific enthalpy in region 4 h(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        SI.Temp_K Tsat "saturation temperature";
        SI.MassFraction x "dryness fraction";
        SI.SpecificEntropy sl "saturated liquid specific entropy";
        SI.SpecificEntropy sv "saturated vapour specific entropy";
        SI.SpecificEnthalpy hl "saturated liquid specific enthalpy";
        SI.SpecificEnthalpy hv "saturated vapour specific enthalpy";
      algorithm
        if (p <= data.PLIMIT4A) then
          Tsat := Basic.tsat(p);
          (hl,sl) := handsofpT1(p, Tsat);
          (hv,sv) := handsofpT2(p, Tsat);
        elseif (p < data.PCRIT) then
          sl := Regions.sl_p_R4b(p);
          sv := Regions.sv_p_R4b(p);
          hl := Regions.hl_p_R4b(p);
          hv := Regions.hv_p_R4b(p);
        end if;
        x := max(min(if sl <> sv then (s - sl)/(sv - sl) else 1.0, 1.0),0.0);
        h := hl + x*(hv - hl);
      end hofps4;

      function hofpT5 "specific enthalpy in region 5 h(p,T)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Real[4] o "vector of auxiliary variables";
        Real tau "dimensionless temperature";
        Real pi "dimensionless pressure";
      algorithm
        tau := data.TSTAR5/T;
        pi := p/data.PSTAR5;
        assert(p > triple.ptriple,
          "IF97 medium function hofpT5 called with too low pressure\n" +
          "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
        o[1] := tau*tau;
        o[2] := o[1]*o[1];
        o[3] := pi*pi;
        o[4] := o[2]*o[2];
        h := data.RH2O*T*tau*(6.8540841634434 + 3.1161318213925/o[1] +
          0.074415446800398/o[2] - 0.0000357523455236121*o[3]*o[4] +
          0.0021774678714571*pi - 0.013782846269973*o[1]*pi +
          3.8757684869352e-7*o[1]*o[3]*pi - 0.73803069960666/(o[1]*tau) -
          0.65923253077834*tau);
      end hofpT5;

      function water_hisentropic
        "isentropic specific enthalpy from p,s (preferably use water_hisentropic_dyn in dynamic simulation!)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
       input Integer phase=
                      0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Modelica.Media.Common.GibbsDerivs g
          "derivatives of dimensionless Gibbs-function w.r.t. dimensionless pi and tau";
        Modelica.Media.Common.HelmholtzDerivs f
          "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless delta and tau";
        Integer region(min=1, max=5) "IF97 region";
        Integer error "error if not 0";
        SI.Temperature T "temperature";
        SI.Density d "density";
      algorithm
        region := Regions.region_ps(p=p,s= s,phase=phase);
        if (region == 1) then
          h := hofps1(p, s);
        elseif (region == 2) then
          h := hofps2(p, s);
        elseif (region == 3) then
          (d,T,error) := Inverses.dtofps3(p=p,s= s,delp= IterationData.DELP,dels=
                 IterationData.DELS);
          h := hofdT3(d, T);
        elseif (region == 4) then
          h := hofps4(p, s);
        elseif (region == 5) then
          (T,error) := Inverses.tofps5(p=p,s= s,relds= IterationData.DELS);
          h := hofpT5(p, T);
        end if;
      end water_hisentropic;

      function water_hisentropic_dyn
        "isentropic specific enthalpy from p,s and good guesses of d and T"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.Density dguess "good guess density, e.g., from adjacent volume";
        input SI.Temperature Tguess
          "good guess temperature, e.g., from adjacent volume";
        input Integer phase "1 for one phase, 2 for two phase";
        output SI.SpecificEnthalpy h "specific enthalpy";
      protected
        Modelica.Media.Common.GibbsDerivs g
          "derivatives of dimensionless Gibbs-function w.r.t. dimensionless pi and tau";
        Modelica.Media.Common.HelmholtzDerivs f
          "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless delta and tau";
        Integer region(min=1, max=5) "IF97 region";
        Integer error "error if not 0";
        SI.Temperature T "temperature";
        SI.Density d "density";
      algorithm
        region := Regions.region_ps(p=p,s= s,phase= phase);
        if (region == 1) then
          h := hofps1(p, s);
        elseif (region == 2) then
          h := hofps2(p, s);
        elseif (region == 3) then
          h := hofpsdt3(p=p,s= s,dguess= dguess,Tguess= Tguess,delp=
            IterationData.DELP,dels= IterationData.DELS);
        elseif (region == 4) then
          h := hofps4(p, s);
        elseif (region == 5) then
          (T,error) := Inverses.tofpst5(p=p,s= s,Tguess= Tguess,relds=
            IterationData.DELS);
          h := hofpT5(p, T);
        end if;
      end water_hisentropic_dyn;

      annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p></p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>hofpT1</b> computes h(p,T) in region 1.</li>
          <li>Function <b>handsofpT1</b> computes (s,h)=f(p,T) in region 1, needed for two-phase properties.</li>
          <li>Function <b>hofps1</b> computes h(p,s) in region 1.</li>
          <li>Function <b>hofpT2</b> computes h(p,T) in region 2.</li>
          <li>Function <b>handsofpT2</b> computes (s,h)=f(p,T) in region 2, needed for two-phase properties.</li>
          <li>Function <b>hofps2</b> computes h(p,s) in region 2.</li>
          <li>Function <b>hofdT3</b> computes h(d,T) in region 3.</li>
          <li>Function <b>hofpsdt3</b> computes h(p,s,dguess,Tguess) in region 3, where dguess and Tguess are initial guess
          values for the density and temperature consistent with p and s.</li>
          <li>Function <b>hofps4</b> computes h(p,s) in region 4.</li>
          <li>Function <b>hofpT5</b> computes h(p,T) in region 5.</li>
          <li>Function <b>water_hisentropic</b> computes h(p,s,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary.</li>
          <li>Function <b>water_hisentropic_dyn</b> computes h(p,s,dguess,Tguess,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary. Tguess and dguess are initial guess
          values for the density and temperature consistent with p and s. This function should be preferred in
          dynamic simulations where good guesses are often available.</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documentation added: December 2002</li>
          </ul>
          </HTML>
          "));
    end Isentropic;
    //work needed: (Pr,lam,eta) = f(d,T,p, region?)
    package Inverses "efficient inverses for selected pairs of variables"

      extends Modelica.Icons.Package;

      //===================================================================
      //            Iterative version for some pairs/regions

      //===================================================================
      function fixdT "region limits for inverse iteration in region 3"

        extends Modelica.Icons.Function;
        input SI.Density din "density";
        input SI.Temperature Tin "temperature";
        output SI.Density dout "density";
        output SI.Temperature Tout "temperature";
      protected
        SI.Temperature Tmin "approximation of minimum temperature";
        SI.Temperature Tmax "approximation of maximum temperature";
      algorithm
        if (din > 765.0) then
          dout := 765.0;
        elseif (din < 110.0) then
          dout := 110.0;
        else
          dout := din;
        end if;
        if (dout < 390.0) then
          Tmax := 554.3557377 + dout*0.809344262;
        else
          Tmax := 1116.85 - dout*0.632948717;
        end if;
        if (dout < data.DCRIT) then
          Tmin := data.TCRIT*(1.0 - (dout - data.DCRIT)*(dout - data.DCRIT)/
            1.0e6);
        else
          Tmin := data.TCRIT*(1.0 - (dout - data.DCRIT)*(dout - data.DCRIT)/
            1.44e6);
        end if;
        if (Tin < Tmin) then
          Tout := Tmin;
        elseif (Tin > Tmax) then
          Tout := Tmax;
        else
          Tout := Tin;
        end if;
      end fixdT;

      function dofp13 "density at the boundary between regions 1 and 3"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Density d "density";
      protected
        Real p2 "auxiliary variable";
        Real[3] o "vector of auxiliary variables";
      algorithm
        p2 := 7.1 - 6.04960677555959e-8*p;
        o[1] := p2*p2;
        o[2] := o[1]*o[1];
        o[3] := o[2]*o[2];
        d := 57.4756752485113/(0.0737412153522555 + p2*(0.00145092247736023 +
          p2*(0.000102697173772229 + p2*(0.0000114683182476084 + p2*(
          1.99080616601101e-6 + o[1]*p2*(1.13217858826367e-8 + o[2]*o[3]*p2*(
          1.35549330686006e-17 + o[1]*(-3.11228834832975e-19 + o[1]*o[2]*(-7.02987180039442e-22
           + p2*(3.29199117056433e-22 + (-5.17859076694812e-23 +
          2.73712834080283e-24*p2)*p2))))))))));

      end dofp13;

      function dofp23 "density at the boundary between regions 2 and 3"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output SI.Density d "density";
      protected
        SI.Temperature T;
        Real[13] o "vector of auxiliary variables";
        Real taug "auxiliary variable";
        Real pi "dimensionless pressure";
        Real gpi23
          "derivative of g w.r.t. pi on the boundary between regions 2 and 3";
      algorithm
        pi := p/data.PSTAR2;
        T := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
        o[1] := (-13.91883977887 + pi)^0.5;
        taug := -0.5 + 540.0/(572.54459862746 + 31.3220101646784*o[1]);
        o[2] := taug*taug;
        o[3] := o[2]*taug;
        o[4] := o[2]*o[2];
        o[5] := o[4]*o[4];
        o[6] := o[5]*o[5];
        o[7] := o[4]*o[5]*o[6]*taug;
        o[8] := o[4]*o[5]*taug;
        o[9] := o[2]*o[4]*o[5];
        o[10] := pi*pi;
        o[11] := o[10]*o[10];
        o[12] := o[4]*o[6]*taug;
        o[13] := o[6]*o[6];

        gpi23 := (1.0 + pi*(-0.0017731742473213 + taug*(-0.017834862292358 +
          taug*(-0.045996013696365 + (-0.057581259083432 - 0.05032527872793*o[3])
          *taug)) + pi*(taug*(-0.000066065283340406 + (-0.0003789797503263 + o[
          2]*(-0.007878555448671 + o[3]*(-0.087594591301146 -
          0.000053349095828174*o[7])))*taug) + pi*(6.1445213076927e-8 + (
          1.31612001853305e-6 + o[2]*(-0.00009683303171571 + o[3]*(-0.0045101773626444
           - 0.122004760687947*o[7])))*taug + pi*(taug*(-3.15389238237468e-9 +
          (5.116287140914e-8 + 1.92901490874028e-6*taug)*taug) + pi*(
          0.0000114610381688305*o[2]*o[4]*taug + pi*(o[3]*(-1.00288598706366e-10
           + o[8]*(-0.012702883392813 - 143.374451604624*o[2]*o[6]*taug)) + pi*
          (-4.1341695026989e-17 + o[2]*o[5]*(-8.8352662293707e-6 -
          0.272627897050173*o[9])*taug + pi*(o[5]*(9.0049690883672e-11 -
          65.8490727183984*o[4]*o[5]*o[6]) + pi*(1.78287415218792e-7*o[8] + pi*
          (o[4]*(1.0406965210174e-18 + o[2]*(-1.0234747095929e-12 -
          1.0018179379511e-8*o[4])*o[4]) + o[10]*o[11]*((-1.29412653835176e-9
           + 1.71088510070544*o[12])*o[7] + o[10]*(-6.05920510335078*o[13]*o[5]
          *o[6]*taug + o[10]*(o[4]*o[6]*(1.78371690710842e-23 + o[2]*o[4]*o[5]*
          (6.1258633752464e-12 - 0.000084004935396416*o[8])*taug) + pi*(-1.24017662339842e-24
          *o[12] + pi*(0.0000832192847496054*o[13]*o[4]*o[6]*taug + pi*(o[2]*o[
          5]*o[6]*(1.75410265428146e-27 + (1.32995316841867e-15 -
          0.0000226487297378904*o[2]*o[6])*o[9])*pi - 2.93678005497663e-14*o[13]
          *o[2]*o[4]*taug)))))))))))))))))/pi;
        d := p/(data.RH2O*T*pi*gpi23);
      end dofp23;

      function dofpt3 "inverse iteration in region 3: (d) = f(p,T)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        input SI.Pressure delp "iteration converged if (p-pre(p) < delp)";
        output SI.Density d "density";
        output Integer error=0
          "error flag: iteration failed if different from 0";
      protected
        SI.Density dguess "guess density";
        Integer i=0 "loop counter";
        Real dp "pressure difference";
        SI.Density deld "density step";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_pT nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";
        Boolean supercritical "flag, true for supercritical states";
        Boolean liquid "flag, true for liquid states";
        SI.Density dmin "lower density limit";
        SI.Density dmax "upper density limit";
        SI.Temperature Tmax "maximum temperature";
      algorithm
        assert(p >= data.PLIMIT4A,
          "BaseIF97.dofpt3: function called outside of region 3! p too low\n" +
          "p = " + String(p) + " Pa < " + String(data.PLIMIT4A) + " Pa");
        assert(T >= data.TLIMIT1,
          "BaseIF97.dofpt3: function called outside of region 3! T too low\n" +
          "T = " + String(T) + " K < " + String(data.TLIMIT1) + " K");
        assert(p >= Regions.boundary23ofT(T),
          "BaseIF97.dofpt3: function called outside of region 3! T too high\n" +
          "p = " + String(p) + " Pa, T = " + String(T) + " K");
        supercritical := p > data.PCRIT;
        dmax := dofp13(p);
        dmin := dofp23(p);
        Tmax := Regions.boundary23ofp(p);
        if supercritical then
          dguess := dmin + (T - data.TLIMIT1)/(data.TLIMIT1 - Tmax)*(dmax -
            dmin);
          //this may need improvement!!
        else
          liquid := T < Basic.tsat(p);
          if liquid then
            dguess := 0.5*(Regions.rhol_p_R4b(p) + dmax);
          else
            dguess := 0.5*(Regions.rhov_p_R4b(p) + dmin);
          end if;
        end if;
        while ((i < IterationData.IMAX) and not found) loop
          d := dguess;
          f := Basic.f3(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_pT(f);
          dp := nDerivs.p - p;
          if (abs(dp/p) <= delp) then
            found := true;
          end if;
          deld := dp/nDerivs.pd;
          d := d - deld;
          if d > dmin and d < dmax then
            dguess := d;
          else
            if d > dmax then
              dguess := dmax - sqrt(Modelica.Constants.eps);
                // put it on the correct spot just inside the boundary here instead
            else
              dguess := dmin + sqrt(Modelica.Constants.eps);
            end if;
          end if;
          i := i + 1;
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1, "error in inverse function dofpt3: iteration failed");
      end dofpt3;

      // for all iteration functions: project to bounadries possible
      // if p is input. Step 1 get dofpt_efficient(p,T) at boundary
      // for T, use boundary itself if off limits, for d a bit inside

      function dtofph3 "inverse iteration in region 3: (d,T) = f(p,h)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        input SI.Pressure delp "iteration accuracy";
        input SI.SpecificEnthalpy delh "iteration accuracy";
        output SI.Density d "density";
        output SI.Temperature T "temperature (K)";
        output Integer error "error flag: iteration failed if different from 0";
      protected
        SI.Temperature Tguess "initial temperature";
        SI.Density dguess "initial density";
        Integer i "iteration counter";
        Real dh "Newton-error in h-direction";
        Real dp "Newton-error in p-direction";
        Real det "determinant of directional derivatives";
        Real deld "Newton-step in d-direction";
        Real delt "Newton-step in T-direction";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_ph nDerivs
          "derivatives needed in Newton iteration";
        Boolean found "flag for iteration success";
        Integer subregion "1 for subregion 3a, 2 for subregion 3b";
      algorithm
        if p < data.PCRIT then
          // allow a 10 J margin inside the (well approximated) phase boundary
          subregion := if h < (Regions.hl_p(p) + 10.0) then 1 else
            if h > (Regions.hv_p(p) - 10.0) then 2 else 0;
          assert(subregion <> 0,"inverse iteration of dt from ph called in 2 phase region: this can not work");
        else
          //supercritical
          subregion := if h < Basic.h3ab_p(p) then 1 else 2;
        end if;
        T := if subregion == 1 then Basic.T3a_ph(p,h) else Basic.T3b_ph(p,h);
        d := if subregion == 1 then 1/Basic.v3a_ph(p,h) else 1/Basic.v3b_ph(p,h);
        i := 0;
        error := 0;
        while ((i < IterationData.IMAX) and not found) loop
          f := Basic.f3(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
          dh := nDerivs.h - h;
          dp := nDerivs.p - p;
          if ((abs(dh/h) <= delh) and (abs(dp/p) <= delp)) then
            found := true;
          end if;
          det := nDerivs.ht*nDerivs.pd - nDerivs.pt*nDerivs.hd;
          delt := (nDerivs.pd*dh - nDerivs.hd*dp)/det;
          deld := (nDerivs.ht*dp - nDerivs.pt*dh)/det;
          T := T - delt;
          d := d - deld;
          dguess := d;
          Tguess := T;
          i := i + 1;
          (d,T) := fixdT(dguess, Tguess);
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1,
          "error in inverse function dtofph3: iteration failed");
      end dtofph3;

      function dtofps3 "inverse iteration in region 3: (d,T) = f(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.Pressure delp "iteration accuracy";
        input SI.SpecificEntropy dels "iteration accuracy";
        output SI.Density d "density";
        output SI.Temperature T "temperature (K)";
        output Integer error "error flag: iteration failed if different from 0";
      protected
        SI.Temperature Tguess "initial temperature";
        SI.Density dguess "initial density";
        Integer i "iteration counter";
        Real ds "Newton-error in s-direction";
        Real dp "Newton-error in p-direction";
        Real det "determinant of directional derivatives";
        Real deld "Newton-step in d-direction";
        Real delt "Newton-step in T-direction";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_ps nDerivs
          "derivatives needed in Newton iteration";
        Boolean found "flag for iteration success";
        Integer subregion "1 for subregion 3a, 2 for subregion 3b";
      algorithm
        i := 0;
        error := 0;
        found := false;
        if p < data.PCRIT then
          // allow a 1 J/K margin inside the (well approximated) phase boundary
          subregion := if s < (Regions.sl_p(p) + 10.0) then 1 else
            if s > (Regions.sv_p(p) - 10.0) then 2 else 0;
          assert(subregion <> 0,"inverse iteration of dt from ps called in 2 phase region: this is illegal!");
        else
          subregion := if s < data.SCRIT then 1 else 2;
        end if;
        T := if subregion == 1 then Basic.T3a_ps(p,s) else Basic.T3b_ps(p,s);
        d := if subregion == 1 then 1/Basic.v3a_ps(p,s) else 1/Basic.v3b_ps(p,s);
        while ((i < IterationData.IMAX) and not found) loop
          f := Basic.f3(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
          ds := nDerivs.s - s;
          dp := nDerivs.p - p;
          if ((abs(ds/s) <= dels) and (abs(dp/p) <= delp)) then
            found := true;
          end if;
          det := nDerivs.st*nDerivs.pd - nDerivs.pt*nDerivs.sd;
          delt := (nDerivs.pd*ds - nDerivs.sd*dp)/det;
          deld := (nDerivs.st*dp - nDerivs.pt*ds)/det;
          T := T - delt;
          d := d - deld;
          dguess := d;
          Tguess := T;
          i := i + 1;
          (d,T) := fixdT(dguess, Tguess);
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1,
          "error in inverse function dtofps3: iteration failed");
      end dtofps3;

      function dtofpsdt3 "inverse iteration in region 3: (d,T) = f(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.Density dguess "guess density, e.g., from adjacent volume";
        input SI.Temperature Tguess
          "guess temperature, e.g., from adjacent volume";
        input SI.Pressure delp "iteration accuracy";
        input SI.SpecificEntropy dels "iteration accuracy";
        output SI.Density d "density";
        output SI.Temperature T "temperature (K)";
        output Integer error "error flag: iteration failed if different from 0";
      protected
        Integer i "iteration counter";
        Real ds "Newton-error in s-direction";
        Real dp "Newton-error in p-direction";
        Real det "determinant of directional derivatives";
        Real deld "Newton-step in d-direction";
        Real delt "Newton-step in T-direction";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_ps nDerivs
          "derivatives needed in Newton iteration";
        Boolean found "flag for iteration success";
        SI.Density diter "density";
        SI.Temperature Titer "temperature (K)";
      algorithm
        i := 0;
        error := 0;
        found := false;
        (diter,Titer) := fixdT(dguess, Tguess);
        while ((i < IterationData.IMAX) and not found) loop
          (d,T) := fixdT(diter, Titer);
          f := Basic.f3(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
          ds := nDerivs.s - s;
          dp := nDerivs.p - p;
          if ((abs(ds/s) <= dels) and (abs(dp/p) <= delp)) then
            found := true;
          end if;
          det := nDerivs.st*nDerivs.pd - nDerivs.pt*nDerivs.sd;
          delt := (nDerivs.pd*ds - nDerivs.sd*dp)/det;
          deld := (nDerivs.st*dp - nDerivs.pt*ds)/det;
          T := T - delt;
          d := d - deld;
          diter := d;
          Titer := T;
          i := i + 1;
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1,
          "error in inverse function dtofpsdt3: iteration failed");
      end dtofpsdt3;

      function pofdt125 "inverse iteration in region 1,2 and 5: p = g(d,T)"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        input SI.Pressure reldd "relative iteration accuracy of density";
        input Integer region
          "region in IAPWS/IF97 in which inverse should be calculated";
        output SI.Pressure p "pressure";
        output Integer error "error flag: iteration failed if different from 0";
      protected
        Integer i "counter for while-loop";
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Boolean found "flag if iteration has been successful";
        Real dd
          "difference between density for  guessed p and the current density";
        Real delp "step in p in Newton-iteration";
        Real relerr "relative error in d";
        SI.Pressure pguess1=1.0e6 "initial pressure guess in region 1";
        SI.Pressure pguess2 "initial pressure guess in region 2";
        constant SI.Pressure pguess5=0.5e6 "initial pressure guess in region 5";
      algorithm
        i := 0;
        error := 0;
        pguess2 := 42800*d;
        found := false;
        if region == 1 then
          p := pguess1;
        elseif region == 2 then
          p := pguess2;
        else
          p := pguess5;
        end if;
        while ((i < IterationData.IMAX) and not found) loop
          if region == 1 then
            g := Basic.g1(p, T);
          elseif region == 2 then
            g := Basic.g2(p, T);
          else
            g := Basic.g5(p, T);
          end if;
          dd := p/(data.RH2O*T*g.pi*g.gpi) - d;
          relerr := dd/d;
          if (abs(relerr) < reldd) then
            found := true;
          end if;
          delp := dd*(-p*p/(d*d*data.RH2O*T*g.pi*g.pi*g.gpipi));
          p := p - delp;
          i := i + 1;
          if not found then
            if p < triple.ptriple then
              p := 2.0*triple.ptriple;
            end if;
            if p > data.PLIMIT1 then
              p := 0.95*data.PLIMIT1;
            end if;
          end if;
        end while;

          // print("i = " + i2s(i) + ", p = " + r2s(p/1.0e5) + ", delp = " + r2s(delp*1.0e-5) + "\n");
        if not found then
          error := 1;
        end if;
        assert(error <> 1,
          "error in inverse function pofdt125: iteration failed");
      end pofdt125;

      function tofph5 "inverse iteration in region 5: (p,T) = f(p,h)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        input SI.SpecificEnthalpy reldh "iteration accuracy";
        output SI.Temperature T "temperature (K)";
        output Integer error "error flag: iteration failed if different from 0";

      protected
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        SI.SpecificEnthalpy proh "h for current guess in T";
        constant SI.Temperature Tguess=1500 "initial temperature";
        Integer i "iteration counter";
        Real relerr "relative error in h";
        Real dh "Newton-error in h-direction";
        Real dT "Newton-step in T-direction";
        Boolean found "flag for iteration success";
      algorithm
        i := 0;
        error := 0;
        T := Tguess;
        found := false;
        while ((i < IterationData.IMAX) and not found) loop
          g := Basic.g5(p, T);
          proh := data.RH2O*T*g.tau*g.gtau;
          dh := proh - h;
          relerr := dh/h;
          if (abs(relerr) < reldh) then
            found := true;
          end if;
          dT := dh/(-data.RH2O*g.tau*g.tau*g.gtautau);
          T := T - dT;
          i := i + 1;
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1, "error in inverse function tofph5: iteration failed");
      end tofph5;

      function tofps5 "inverse iteration in region 5: (p,T) = f(p,s)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.SpecificEnthalpy relds "iteration accuracy";
        output SI.Temperature T "temperature (K)";
        output Integer error "error flag: iteration failed if different from 0";

      protected
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        SI.SpecificEntropy pros "s for current guess in T";
        parameter SI.Temperature Tguess=1500 "initial temperature";
        Integer i "iteration counter";
        Real relerr "relative error in s";
        Real ds "Newton-error in s-direction";
        Real dT "Newton-step in T-direction";
        Boolean found "flag for iteration success";
      algorithm
        i := 0;
        error := 0;
        T := Tguess;
        found := false;
        while ((i < IterationData.IMAX) and not found) loop
          g := Basic.g5(p, T);
          pros := data.RH2O*(g.tau*g.gtau - g.g);
          ds := pros - s;
          relerr := ds/s;
          if (abs(relerr) < relds) then
            found := true;
          end if;
          dT := ds*T/(-data.RH2O*g.tau*g.tau*g.gtautau);
          T := T - dT;
          i := i + 1;
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1, "error in inverse function tofps5: iteration failed");
      end tofps5;

      function tofpst5 "inverse iteration in region 5: (p,T) = f(p,s)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.Temperature Tguess
          "guess temperature, e.g., from adjacent volume";
        input SI.SpecificEntropy relds "iteration accuracy";
        output SI.Temperature T "temperature (K)";
        output Integer error "error flag: iteration failed if different from 0";

      protected
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        SI.SpecificEntropy pros "s for current guess in T";
        Integer i "iteration counter";
        Real relerr "relative error in s";
        Real ds "Newton-error in s-direction";
        Real dT "Newton-step in T-direction";
        Boolean found "flag for iteration success";
      algorithm
        i := 0;
        error := 0;
        T := Tguess;
        found := false;
        while ((i < IterationData.IMAX) and not found) loop
          g := Basic.g5(p, T);
          pros := data.RH2O*(g.tau*g.gtau - g.g);
          ds := pros - s;
          relerr := ds/s;
          if (abs(relerr) < relds) then
            found := true;
          end if;
          dT := ds*T/(-data.RH2O*g.tau*g.tau*g.gtautau);
          T := T - dT;
          i := i + 1;
        end while;
        if not found then
          error := 1;
        end if;
        assert(error <> 1,
          "error in inverse function tofpst5: iteration failed");
      end tofpst5;

      annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p></p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>fixdT</b> constrains density and temperature to allowed region</li>
          <li>Function <b>dofp13</b> computes d as a function of p at boundary between regions 1 and 3</li>
          <li>Function <b>dofp23</b> computes d as a function of p at boundary between regions 2 and 3</li>
          <li>Function <b>dofpt3</b> iteration to compute d as a function of p and T in region 3</li>
          <li>Function <b>dtofph3</b> iteration to compute d and T as a function of p and h in region 3</li>
          <li>Function <b>dtofps3</b> iteration to compute d and T as a function of p and s in region 3</li>
          <li>Function <b>dtofpsdt3</b> iteration to compute d and T as a function of p and s in region 3,
          with initial guesses</li>
          <li>Function <b>pofdt125</b> iteration to compute p as a function of p and T in regions 1, 2 and 5</li>
          <li>Function <b>tofph5</b> iteration to compute T as a function of p and h in region 5</li>
          <li>Function <b>tofps5</b> iteration to compute T as a function of p and s in region 5</li>
          <li>Function <b>tofpst5</b> iteration to compute T as a function of p and s in region 5, with initial guess in T</li>
          <li>Function <b></b></li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documentation added: December 2002</li>
          </ul>
          </HTML>
          "));
    end Inverses;

    package ByRegion "simple explicit functions for one region only"

      extends Modelica.Icons.Package;
      function waterR1_pT "standard properties for region 1, (p,T) as inputs"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT pro
          "thermodynamic property collection";

      protected
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      algorithm
        g := Basic.g1(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_pT(g);
      end waterR1_pT;

      function waterR2_pT "standard properties for region 2, (p,T) as inputs"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT pro
          "thermodynamic property collection";
      protected
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      algorithm
        g := Basic.g2(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_pT(g);
      end waterR2_pT;

      function waterR3_dT "standard properties for region 3, (d,T) as inputs"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        output Common.ThermoFluidSpecial.ThermoProperties_dT pro
          "thermodynamic property collection";
      protected
        Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      algorithm
        f := Basic.f3(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
        assert(pro.p <= 100.0e6,
          "IF97 medium function waterR3_dT: the input pressure (= " + String(pro.p) +
          " Pa) is higher than 100 Mpa");
      end waterR3_dT;

      function waterR5_pT "standard properties for region 5, (p,T) as inputs"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT pro
          "thermodynamic property collection";
      protected
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      algorithm
        g := Basic.g5(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_pT(g);
      end waterR5_pT;
      annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package ByRegion provides fast forward calls for dynamic property calculation records for all
          one phase regions of IAPWS/IF97
       </p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>waterR1_pT</b> computes dynamic properties for region 1 using  (p,T) as inputs</li>
          <li>Function <b>waterR2_pT</b> computes dynamic properties for region 2 using  (p,T) as inputs</li>
          <li>Function <b>waterR3_dT</b> computes dynamic properties for region 3 using  (d,T) as inputs</li>
          <li>Function <b>waterR5_pT</b> computes dynamic properties for region 5 using  (p,T) as inputs</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documented and re-organized: January 2003</li>
          </ul>
          </HTML>
          "));
    end ByRegion;

    package TwoPhase
      "steam properties in the two-phase rgion and on the phase boundaries"

      extends Modelica.Icons.Package;

      function waterLiq_p "properties on the liquid phase boundary of region 4"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output Modelica.Media.Common.PhaseBoundaryProperties liq
          "liquid thermodynamic property collection";
      protected
        SI.Temperature Tsat "saturation temperature";
        Real dpT "derivative of saturation pressure w.r.t. temperature";
        SI.Density dl "liquid density";
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      algorithm
        Tsat := Basic.tsat(p);
        dpT := Basic.dptofT(Tsat);
        if p < data.PLIMIT4A then
          g := Basic.g1(p, Tsat);
          liq := Modelica.Media.Common.gibbsToBoundaryProps(g);
        else
          dl := Regions.rhol_p_R4b(p);
          f := Basic.f3(dl, Tsat);
          liq := Modelica.Media.Common.helmholtzToBoundaryProps(f);
        end if;
      end waterLiq_p;

      function waterVap_p "properties on the vapour phase boundary of region 4"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        output Modelica.Media.Common.PhaseBoundaryProperties vap
          "vapour thermodynamic property collection";
      protected
        SI.Temperature Tsat "saturation temperature";
        Real dpT "derivative of saturation pressure w.r.t. temperature";
        SI.Density dv "vapour density";
        Modelica.Media.Common.GibbsDerivs g
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      algorithm
        Tsat := Basic.tsat(p);
        dpT := Basic.dptofT(Tsat);
        if p < data.PLIMIT4A then
          g := Basic.g2(p, Tsat);
          vap := Modelica.Media.Common.gibbsToBoundaryProps(g);
        else
          dv := Regions.rhov_p_R4b(p);
          f := Basic.f3(dv, Tsat);
          vap := Modelica.Media.Common.helmholtzToBoundaryProps(f);
        end if;
      end waterVap_p;

      function waterSat_ph
        "Water saturation properties in the 2-phase region (4) as f(p,h)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        output Modelica.Media.Common.SaturationProperties pro
          "thermodynamic property collection";
      protected
        SI.Density dl "liquid density";
        SI.Density dv "vapour density";
        Modelica.Media.Common.GibbsDerivs gl
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.GibbsDerivs gv
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs fl
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.HelmholtzDerivs fv
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      algorithm
        pro.h := h;
        pro.p := p;
        pro.T := Basic.tsat(p);
        pro.dpT := Basic.dptofT(pro.T);
        if p < data.PLIMIT4A then
          gl := Basic.g1(p, pro.T);
          gv := Basic.g2(p, pro.T);
          pro.liq := Modelica.Media.Common.gibbsToBoundaryProps(gl);
          pro.vap := Modelica.Media.Common.gibbsToBoundaryProps(gv);
        else
          dl := Regions.rhol_p_R4b(p);
          dv := Regions.rhov_p_R4b(p);
          fl := Basic.f3(dl, pro.T);
          fv := Basic.f3(dv, pro.T);
          pro.liq := Modelica.Media.Common.helmholtzToBoundaryProps(fl);
          pro.vap := Modelica.Media.Common.helmholtzToBoundaryProps(fv);
        end if;
        pro.x := if (h < pro.liq.h) then 0.0 else if (pro.vap.h <> pro.liq.h) then
                (h - pro.liq.h)/(pro.vap.h - pro.liq.h) else 1.0;
        pro.d := pro.liq.d*pro.vap.d/(pro.vap.d + pro.x*(pro.liq.d - pro.vap.d));
        pro.u := pro.x*pro.vap.u + (1 - pro.x)*pro.liq.u;
        pro.s := pro.x*pro.vap.s + (1 - pro.x)*pro.liq.s;
        pro.cp := Modelica.Constants.inf;
        pro.cv := Modelica.Media.Common.cv2Phase(pro.liq, pro.vap, pro.x, pro.T,
           p);
        pro.kappa := 1/(pro.d*p)*pro.dpT*pro.dpT*pro.T/pro.cv;
        pro.R := data.RH2O;
      end waterSat_ph;

      function waterR4_ph
        "Water/Steam properties in region 4 of IAPWS/IF97 (two-phase)"

        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_ph pro
          "thermodynamic property collection";
      protected
        SI.Density dl "liquid density";
        SI.Density dv "vapour density";
        Modelica.Media.Common.PhaseBoundaryProperties liq
          "phase boundary property record";
        Modelica.Media.Common.PhaseBoundaryProperties vap
          "phase boundary property record";
        Modelica.Media.Common.GibbsDerivs gl
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.GibbsDerivs gv
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs fl
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.HelmholtzDerivs fv
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Real x "dryness fraction";
        Real dpT "derivative of saturation curve";
      algorithm
        pro.T := Basic.tsat(p);
        dpT := Basic.dptofT(pro.T);
        dl := Regions.rhol_p_R4b(p);
        dv := Regions.rhov_p_R4b(p);
        if p < data.PLIMIT4A then
          gl := Basic.g1(p, pro.T);
          gv := Basic.g2(p, pro.T);
          liq := Modelica.Media.Common.gibbsToBoundaryProps(gl);
          vap := Modelica.Media.Common.gibbsToBoundaryProps(gv);
        else
          fl := Basic.f3(dl, pro.T);
          fv := Basic.f3(dv, pro.T);
          liq := Modelica.Media.Common.helmholtzToBoundaryProps(fl);
          vap := Modelica.Media.Common.helmholtzToBoundaryProps(fv);
        end if;
        x := if (vap.h <> liq.h) then (h - liq.h)/(vap.h - liq.h) else 1.0;
        pro.d := liq.d*vap.d/(vap.d + x*(liq.d - vap.d));
        pro.u := x*vap.u + (1 - x)*liq.u;
        pro.s := x*vap.s + (1 - x)*liq.s;
        pro.cp := Modelica.Constants.inf;
        pro.cv := Modelica.Media.Common.cv2Phase(liq, vap, x, pro.T, p);
        pro.kappa := 1/(pro.d*p)*dpT*dpT*pro.T/pro.cv;
        pro.a := Modelica.Constants.inf;
        pro.R := data.RH2O;
        pro.ddph := pro.d*(pro.d*pro.cv/dpT + 1.0)/(dpT*pro.T);
        pro.ddhp := -pro.d*pro.d/(dpT*pro.T);
      end waterR4_ph;

      function waterR4_dT "Water properties in region 4 as function of d and T"

        extends Modelica.Icons.Function;
        input SI.Density d "Density";
        input SI.Temperature T "temperature";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_dT pro
          "thermodynamic property collection";
      protected
        SI.Density dl "liquid density";
        SI.Density dv "vapour density";
        Modelica.Media.Common.PhaseBoundaryProperties liq
          "phase boundary property record";
        Modelica.Media.Common.PhaseBoundaryProperties vap
          "phase boundary property record";
        Modelica.Media.Common.GibbsDerivs gl
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.GibbsDerivs gv
          "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs fl
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.HelmholtzDerivs fv
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Real x "dryness fraction";
        Real dpT "derivative of saturation curve";
      algorithm
        pro.p := Basic.psat(T);
        dpT := Basic.dptofT(T);
        dl := Regions.rhol_p_R4b(pro.p);
        dv := Regions.rhov_p_R4b(pro.p);
        if pro.p < data.PLIMIT4A then
          gl := Basic.g1(pro.p, T);
          gv := Basic.g2(pro.p, T);
          liq := Modelica.Media.Common.gibbsToBoundaryProps(gl);
          vap := Modelica.Media.Common.gibbsToBoundaryProps(gv);
        else
          fl := Basic.f3(dl, T);
          fv := Basic.f3(dv, T);
          liq := Modelica.Media.Common.helmholtzToBoundaryProps(fl);
          vap := Modelica.Media.Common.helmholtzToBoundaryProps(fv);
        end if;
        x := if (vap.d <> liq.d) then (1/d - 1/liq.d)/(1/vap.d - 1/liq.d) else
          1.0;
        pro.u := x*vap.u + (1 - x)*liq.u;
        pro.h := x*vap.h + (1 - x)*liq.h;
        pro.cp := Modelica.Constants.inf;
        pro.cv := Modelica.Media.Common.cv2Phase(liq, vap, x, T, pro.p);
        pro.kappa := 1/(d*pro.p)*dpT*dpT*T/pro.cv;
        pro.a := Modelica.Constants.inf;
        pro.R := data.RH2O;
        pro.dudT := (pro.p - T*dpT)/(d*d);
      end waterR4_dT;
      annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package TwoPhase provides functions to compute the steam properties
          in the two-phase region and on the phase boundaries</p>
          <h4>Package contents</h4>
          <p>
          <ul>
          <li>Function <b>WaterLiq_p</b> computes properties on the boiling boundary as a function of p</li>
          <li>Function <b>WaterVap_p</b> computes properties on the dew line boundary as a function of p</li>
          <li>Function <b>WaterSat_ph</b> computes properties on both phase boundaries and in the two
          phase region as a function of p</li>
          <li>Function <b>WaterR4_ph</b> computes dynamic simulation properties in region 4 with (p,h) as inputs</li>
          <li>Function <b>WaterR4_dT</b> computes dynamic simulation properties in region 4 with (d,T) as inputs</li>
          </ul>
       </p>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documented and re-organized: January 2003</li>
          </ul>
          </HTML>
"));
    end TwoPhase;

    function extraDerivs_ph
      "function to calculate some extra thermophysical properties in regions 1, 2, 3 and 5 as f(p,h)"

      extends Modelica.Icons.Function;
      input SI.Pressure p "pressure";
      input SI.SpecificEnthalpy h "specific enthalpy";
      input Integer phase= 0
        "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
      output Modelica.Media.Common.ExtraDerivatives dpro
        "thermodynamic property collection";
    protected
      SI.Density d "density";
      SI.Temperature T "temperature";
      Integer region "IF97 region";
      Integer error "error flag";
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      Modelica.Media.Common.GibbsDerivs g
        "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    algorithm
      assert(phase ==1,
        "extraDerivs_ph: properties are not implemented in 2 phase region");
      region := Regions.region_ph(p=p,h= h,phase= phase);
      if region == 1 then
        T := Basic.tph1(p, h);
        g := Basic.g1(p, T);
        dpro := Modelica.Media.Common.gibbsToExtraDerivs(g);
      elseif region == 2 then
        T := Basic.tph2(p, h);
        g := Basic.g2(p, T);
        dpro := Modelica.Media.Common.gibbsToExtraDerivs(g);
      elseif region == 3 then
        (d,T,error) := Inverses.dtofph3(p=p,h= h,delp= 1.0e-7,delh= 1.0e-6);
        f := Basic.f3(d, T);
        dpro := Modelica.Media.Common.helmholtzToExtraDerivs(f);
      elseif region == 5 then
        // region assumed to be 5
        (T,error) := Inverses.tofph5(p=p,h= h,reldh= 1.0e-7);
        g := Basic.g5(p, T);
        dpro := Modelica.Media.Common.gibbsToExtraDerivs(g);
      end if;
    end extraDerivs_ph;

    function extraDerivs_pT
      "function to calculate some extra thermophysical properties in regions 1, 2, 3 and 5 as f(p,T)"

      extends Modelica.Icons.Function;
      input SI.Pressure p "pressure";
      input SI.Temperature T "temperature";
      output Modelica.Media.Common.ExtraDerivatives dpro
        "thermodynamic property collection";
    protected
      SI.Density d "density";
      Integer region "IF97 region";
      Integer error "error flag";
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
      Modelica.Media.Common.GibbsDerivs g
        "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    algorithm
      region := Regions.region_pT(p=p,T= T);
      if region == 1 then
        g := Basic.g1(p, T);
        dpro := Modelica.Media.Common.gibbsToExtraDerivs(g);
      elseif region == 2 then
        g := Basic.g2(p, T);
        dpro := Modelica.Media.Common.gibbsToExtraDerivs(g);
      elseif region == 3 then
        (d,error) := Inverses.dofpt3(p=p,T= T,delp= 1.0e-7);
        f := Basic.f3(d, T);
        dpro := Modelica.Media.Common.helmholtzToExtraDerivs(f);
      elseif region == 5 then
        // region assumed to be 5
        g := Basic.g5(p, T);
        dpro := Modelica.Media.Common.gibbsToExtraDerivs(g);
      end if;
    end extraDerivs_pT;

    annotation (Documentation(info="<HTML>
    <h4>Version Info and Revision history
        </h4>
        <ul>
        <li>First implemented: <i>July, 2000</i>
        by Hubertus Tummescheit
        for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
        </li>
      <li>Code reorganization, enhanced documentation, additional functions:   <i>December, 2002</i>
      by <a href=\"mailto:Hubertus.Tummescheit@modelon.se\">Hubertus Tummescheit</a> and moved to Modelica
      properties library.</li>
        </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
      </address>
        <P>In September 1997, the International Association for the Properties
        of Water and Steam (<A HREF=\"http://www.iapws.org\">IAPWS</A>) adopted a
        new formulation for the thermodynamic properties of water and steam for
        industrial use. This new industrial standard is called \"IAPWS Industrial
        Formulation for the Thermodynamic Properties of Water and Steam\" (IAPWS-IF97).
        The formulation IAPWS-IF97 replaces the previous industrial standard IFC-67.
        <P>Based on this new formulation, a new steam table, titled \"<a
        href=\"http://www.springer.de/cgi-bin/search_book.pl?isbn=3-540-64339-7\">Properties
        of Water and Steam</a>\" by W. Wagner and A. Kruse, was published by
        the Springer-Verlag, Berlin - New-York - Tokyo in April 1998. This
        steam table, ref. <a href=\"#steamprop\">[1]</a> is bilingual (English /
        German) and contains a complete description of the equations of
        IAPWS-IF97. This reference is the authoritative source of information
        for this implementation. A mostly identical version has been published by the International
        Association for the Properties
        of Water and Steam (<A HREF=\"http://www.iapws.org\">IAPWS</A>) with permission granted to re-publish the
        information if credit is given to IAPWS. This document is distributed with this library as
        <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a>.
        In addition, the equations published by <A HREF=\"http://www.iapws.org\">IAPWS</A> for
        the transport properties dynamic viscosity (standards document: <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/visc.pdf\">visc.pdf</a>)
        and thermal conductivity (standards document: <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/thcond.pdf\">thcond.pdf</a>)
        and equations for the surface tension (standards document: <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/surf.pdf\">surf.pdf</a>)
        are also implemented in this library and included for reference.
        <P>
        The functions in BaseIF97.mo are low level functions which should
        only be used in those exceptions when the standard user level
        functions in Water.mo do not contain the wanted properties.
     </p>
<P>Based on IAPWS-IF97, Modelica functions are available for calculating
the most common thermophysical properties (thermodynamic and transport
properties). The implementation requires part of the common medium
property infrastructure of the Modelica.Thermal.Properties library in the file
Common.mo. There are a few extensions from the version of IF97 as
documented in <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a> in order to improve performance for
dynamic simulations. Input variables for calculating the properties are
only implemented for a limited number of variable pairs which make sense as dynamic states: (p,h), (p,T), (p,s) and (d,T).
</p>
<hr size=3 width=\"70%\">
<p><a name=\"regions\"><h4>1. Structure and Regions of IAPWS-IF97</h4></a>
<P>The IAPWS Industrial Formulation 1997 consists of
a set of equations for different regions which cover the following range
of validity:</p>
<table border=0 cellpadding=4 align=center>
<tr>
<td valign=\"top\">273,15 K &lt; <I>T</I> &lt; 1073,15 K</td>
<td valign=\"top\"><I>p</I> &lt; 100 MPa</td>
</tr>
<tr>
<td valign=\"top\">1073,15 K &lt; <I>T</I> &lt; 2273,15 K</td>
<td valign=\"top\"><I>p</I> &lt; 10 MPa</td>
</tr>
</table>
<p>
Figure 1 shows the 5 regions into which the entire range of validity of
IAPWS-IF97 is divided. The boundaries of the regions can be directly taken
from Fig. 1 except for the boundary between regions 2 and 3; this boundary,
which corresponds approximately to the isentropic line <nobr><I>s</I> = 5.047 kJ kg
<FONT SIZE=-1><sup>-1</sup></FONT>
K<FONT SIZE=-1><sup>-1</sup></FONT>,</nobr> is defined
by a corresponding auxiliary equation. Both regions 1 and 2 are individually
covered by a fundamental equation for the specific Gibbs free energy <nobr><I>g</I>(<I>
p</I>,<I>T </I>)</nobr>, region 3 by a fundamental equation for the specific Helmholtz
free energy <nobr><I>f </I>(<I> <FONT FACE=\"Symbol\">r</FONT></I>,<I>T
</I>)</nobr>, and the saturation curve, corresponding to region 4, by a saturation-pressure
equation <nobr><I>p</I><FONT SIZE=-1><sub>s</sub></FONT>(<I>T</I>)</nobr>. The high-temperature
region 5 is also covered by a <nobr><I>g</I>(<I> p</I>,<I>T </I>)</nobr> equation. These
5 equations, shown in rectangular boxes in Fig. 1, form the so-called <I>basic
equations</I>.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Figure 1: Regions and equations of IAPWS-IF97</caption>
  <tr>
    <td>
    <img src=\"modelica://Modelica/Resources/Images/Media/Water/if97.png\" alt=\"Regions and equations of IAPWS-IF97\">
    </td>
  </tr>
</table>

<P>In addition to these basic equations, so-called <I>backward
equations</I> are provided for regions 1, 2, and 4 in form of
<nobr><I>T </I>(<I> p</I>,<I>h </I>)</nobr> and <nobr><I>T </I>(<I>
p</I>,<I>s </I>)</nobr> for regions 1 and 2, and <nobr><I>T</I><FONT
SIZE=-1><sub>s</sub> </FONT>(<I> p </I>)</nobr> for region 4. These
backward equations, marked in grey in Fig. 1, were developed in such a
way that they are numerically very consistent with the corresponding
basic equation. Thus, properties as functions of&nbsp; <I>p</I>,<I>h
</I>and of&nbsp;<I> p</I>,<I>s </I>for regions 1 and 2, and of
<I>p</I> for region 4 can be calculated without any iteration. As a
result of this special concept for the development of the new
industrial standard IAPWS-IF97, the most important properties can be
calculated extremely quickly. All modelica functions are optimized
with regard to short computing times.
<P>The complete description of the individual equations of the new industrial
formulation IAPWS-IF97 is given in <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a>. Comprehensive information on
IAPWS-IF97 (requirements, concept, accuracy, consistency along region boundaries,
and the increase of computing speed in comparison with IFC-67, etc.) can
be taken from <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a> or [2].
<P><a name=\"steamprop\">[1]<I>Wagner, W., Kruse, A.</I> Properties of Water
and Steam / Zustandsgr&ouml;&szlig;en von Wasser und Wasserdampf / IAPWS-IF97.
Springer-Verlag, Berlin, 1998.
<P>[2] <I>Wagner, W., Cooper, J. R., Dittmann, A., Kijima,
J., Kretzschmar, H.-J., Kruse, A., Mare&#353; R., Oguchi, K., Sato, H., St&ouml;cker,
I., &#352;ifner, O., Takaishi, Y., Tanishita, I., Tr&uuml;benbach, J., and Willkommen,
Th.</I> The IAPWS Industrial Formulation 1997 for the Thermodynamic Properties
of Water and Steam. ASME Journal of Engineering for Gas Turbines and Power 122 (2000), 150 - 182.
<p>
<HR size=3 width=\"90%\">
<h4>2. Calculable Properties      </h4>
<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\">
       <tbody>
       <tr>
       <td valign=\"top\" bgcolor=\"#cccccc\"><br>
      </td>
      <td valign=\"top\" bgcolor=\"#cccccc\"><b>Common name</b><br>
       </td>
       <td valign=\"top\" bgcolor=\"#cccccc\"><b>Abbreviation </b><br>
       </td>
       <td valign=\"top\" bgcolor=\"#cccccc\"><b>Unit</b><br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;1<br>
      </td>
      <td valign=\"top\">Pressure</td>
       <td valign=\"top\">p<br>
        </td>
       <td valign=\"top\">Pa<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;2<br>
      </td>
      <td valign=\"top\">Temperature</td>
       <td valign=\"top\">T<br>
       </td>
       <td valign=\"top\">K<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;3<br>
      </td>
      <td valign=\"top\">Density</td>
        <td valign=\"top\">d<br>
        </td>
       <td valign=\"top\">kg/m<sup>3</sup><br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;4<br>
      </td>
      <td valign=\"top\">Specific volume</td>
        <td valign=\"top\">v<br>
        </td>
       <td valign=\"top\">m<sup>3</sup>/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;5<br>
      </td>
      <td valign=\"top\">Specific enthalpy</td>
       <td valign=\"top\">h<br>
       </td>
       <td valign=\"top\">J/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;6<br>
      </td>
      <td valign=\"top\">Specific entropy</td>
       <td valign=\"top\">s<br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;7<br>
      </td>
      <td valign=\"top\">Specific internal energy<br>
       </td>
       <td valign=\"top\">u<br>
       </td>
       <td valign=\"top\">J/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;8<br>
      </td>
      <td valign=\"top\">Specific isobaric heat capacity</td>
       <td valign=\"top\">c<font size=\"-1\"><sub>p</sub></font><br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;9<br>
      </td>
      <td valign=\"top\">Specific isochoric heat capacity</td>
       <td valign=\"top\">c<font size=\"-1\"><sub>v</sub></font><br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">10<br>
      </td>
      <td valign=\"top\">Isentropic exponent, kappa<nobr>=       <font face=\"Symbol\">-</font>(v/p)
(dp/dv)<font size=\"-1\"><sub>s</sub> </font></nobr></td>
     <td valign=\"top\">kappa (     <font face=\"Symbol\">k</font>)<br>
     </td>
     <td valign=\"top\">1<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">11<br>
      </td>
      <td valign=\"top\">Speed of sound<br>
     </td>
     <td valign=\"top\">a<br>
     </td>
     <td valign=\"top\">m/s<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">12<br>
      </td>
      <td valign=\"top\">Dryness fraction<br>
     </td>
     <td valign=\"top\">x<br>
     </td>
     <td valign=\"top\">kg/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">13<br>
      </td>
      <td valign=\"top\">Specific Helmholtz free energy,     f = u - Ts</td>
     <td valign=\"top\">f<br>
     </td>
     <td valign=\"top\">J/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">14<br>
      </td>
      <td valign=\"top\">Specific Gibbs free energy,     g = h - Ts</td>
     <td valign=\"top\">g<br>
     </td>
     <td valign=\"top\">J/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">15<br>
      </td>
      <td valign=\"top\">Isenthalpic exponent, <nobr> theta     = -(v/p)(dp/dv)<font
 size=\"-1\"><sub>h</sub></font></nobr></td>
     <td valign=\"top\">theta (<font face=\"Symbol\">q</font>)<br>
     </td>
     <td valign=\"top\">1<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">16<br>
      </td>
      <td valign=\"top\">Isobaric volume expansion coefficient,     alpha = v<font
 size=\"-1\"><sup>-1</sup></font>       (dv/dT)<font size=\"-1\"><sub>p</sub>
    </font></td>
     <td valign=\"top\">alpha  (<font face=\"Symbol\">a</font>)<br>
     </td>
       <td valign=\"top\">1/K<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">17<br>
      </td>
      <td valign=\"top\">Isochoric pressure coefficient,     <nobr>beta = p<font
 size=\"-1\"><sup><font face=\"Symbol\">-</font>1</sup>     </font>(dp/dT)<font
 size=\"-1\"><sub>v</sub></font></nobr>     </td>
     <td valign=\"top\">beta (<font face=\"Symbol\">b</font>)<br>
     </td>
     <td valign=\"top\">1/K<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">18<br>
      </td>
      <td valign=\"top\">Isothermal compressibility,     g<nobr>amma  = <font
 face=\"Symbol\">-</font>v        <sup><font size=\"-1\"><font face=\"Symbol\">-</font>1</font></sup>(dv/dp)<font
 size=\"-1\"><sub>T</sub></font></nobr> </td>
        <td valign=\"top\">gamma (<font face=\"Symbol\">g</font>)<br>
     </td>
     <td valign=\"top\">1/Pa<br>
     </td>
     </tr>
     <!-- <tr><td valign=\"top\">f</td><td valign=\"top\">Fugacity</td></tr> --> <tr>
     <td valign=\"top\">19<br>
      </td>
      <td valign=\"top\">Dynamic viscosity</td>
     <td valign=\"top\">eta (<font face=\"Symbol\">h</font>)<br>
     </td>
     <td valign=\"top\">Pa s<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">20<br>
      </td>
      <td valign=\"top\">Kinematic viscosity</td>
     <td valign=\"top\">nu (<font face=\"Symbol\">n</font>)<br>
     </td>
     <td valign=\"top\">m<sup>2</sup>/s<br>
     </td>
     </tr>
     <!-- <tr><td valign=\"top\">Pr</td><td valign=\"top\">Prandtl number</td></tr> --> <tr>
     <td valign=\"top\">21<br>
      </td>
      <td valign=\"top\">Thermal conductivity</td>
     <td valign=\"top\">lambda (<font face=\"Symbol\">l</font>)<br>
     </td>
     <td valign=\"top\">W/(m K)<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">22 <br>
      </td>
      <td valign=\"top\">Surface tension</td>
     <td valign=\"top\">sigma (<font face=\"Symbol\">s</font>)<br>
     </td>
     <td valign=\"top\">N/m<br>
     </td>
     </tr>
  </tbody>
</table>
        <p>The properties 1-11 are calculated by default with the functions for dynamic
        simulation, 2 of these variables are the dynamic states and are the inputs
        to calculate all other properties. In addition to these properties
        of general interest, the entries to the thermodynamic Jacobian matrix which render
        the mass- and energy balances explicit in the input variables to the property calculation are also calculated.
        For an explanatory example using pressure and specific enthalpy as states, see the Examples sub-package.</p>
        <p>The high-level calls to steam properties are grouped into records comprising both the properties of general interest
        and the entries to the thermodynamic Jacobian. If additional properties are
        needed the low level functions in BaseIF97 provide more choice.</p>
        <HR size=3 width=\"90%\">
        <h4>Additional functions</h4>
        <ul>
        <li>Function <b>boundaryvals_p</b> computes the temperature and the specific enthalpy and
        entropy on both phase boundaries as a function of p</li>
        <li>Function <b>boundaryderivs_p</b> is the Modelica derivative function of <b>boundaryvals_p</b></li>
        <li>Function <b>extraDerivs_ph</b> computes all entries to Bridgmans tables for all
        one-phase regions of IF97 using inputs (p,h). All 336 directional derivatives of the
        thermodynamic surface can be computed as a ratio of two entries in the return data, see package Common
        for details.</li>
        <li>Function <b>extraDerivs_pT</b> computes all entries to Bridgmans tables for all
        one-phase regions of IF97 using inputs (p,T).</li>
        </ul>
     </p>
        </HTML>"));
  end BaseIF97;

  replaceable record iter = BaseIF97.IterationData;

  function waterBaseProp_ph "intermediate property record for water"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase =  0
      "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    input Integer region = 0
      "if 0, do region computation, otherwise assume the region is this input";
    output Common.IF97BaseTwoPhase aux "auxiliary record";
  protected
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Integer error "error flag for inverse iterations";
    SI.SpecificEnthalpy h_liq "liquid specific enthalpy";
    SI.Density d_liq "liquid density";
    SI.SpecificEnthalpy h_vap "vapour specific enthalpy";
    SI.Density d_vap "vapour density";
    Common.PhaseBoundaryProperties liq "phase boundary property record";
    Common.PhaseBoundaryProperties vap "phase boundary property record";
    Common.GibbsDerivs gl
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.GibbsDerivs gv
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Modelica.Media.Common.HelmholtzDerivs fl
      "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
    Modelica.Media.Common.HelmholtzDerivs fv
      "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
    SI.Temperature t1
      "temperature at phase boundary, using inverse from region 1";
    SI.Temperature t2
      "temperature at phase boundary, using inverse from region 2";
  algorithm
    aux.region := if region == 0 then
      (if phase == 2 then 4 else BaseIF97.Regions.region_ph(p=p,h= h,phase= phase)) else region;
    aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
    aux.p := max(p,611.657);
    aux.h := max(h,1e3);
    aux.R := BaseIF97.data.RH2O;
    if (aux.region == 1) then
      aux.T := BaseIF97.Basic.tph1(aux.p, aux.h);
      g := BaseIF97.Basic.g1(p, aux.T);
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 0.0;
      aux.dpT := -aux.vt/aux.vp;
    elseif (aux.region == 2) then
      aux.T := BaseIF97.Basic.tph2(aux.p, aux.h);
      g := BaseIF97.Basic.g2(p, aux.T);
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 1.0;
      aux.dpT := -aux.vt/aux.vp;
    elseif (aux.region == 3) then
      (aux.rho,aux.T,error) := BaseIF97.Inverses.dtofph3(p=aux.p,h=aux.h,delp= 1.0e-7,delh=
              1.0e-6);
      f := BaseIF97.Basic.f3(aux.rho, aux.T);
      aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta);
      aux.s := aux.R*(f.tau*f.ftau - f.f);
      aux.pd := aux.R*aux.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := abs(aux.R*(-f.tau*f.tau*f.ftautau))
        "can be close to neg. infinity near critical point";
      aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd);
      aux.x := 0.0;
      aux.dpT := aux.pt; /*safety against div-by-0 in initialization*/
    elseif (aux.region == 4) then
      h_liq := hl_p(p);
      h_vap := hv_p(p);
      aux.x := if (h_vap <> h_liq) then (h - h_liq)/(h_vap - h_liq) else 1.0;
      if p < BaseIF97.data.PLIMIT4A then
        t1:= BaseIF97.Basic.tph1(aux.p, h_liq);
        t2:= BaseIF97.Basic.tph2(aux.p, h_vap);
        gl := BaseIF97.Basic.g1(aux.p, t1);
        gv := BaseIF97.Basic.g2(aux.p, t2);
        liq := Common.gibbsToBoundaryProps(gl);
        vap := Common.gibbsToBoundaryProps(gv);
        aux.T := t1 + aux.x*(t2-t1);
      else
        aux.T := BaseIF97.Basic.tsat(aux.p); // how to avoid ?
        d_liq:= rhol_T(aux.T);
        d_vap:= rhov_T(aux.T);
        fl := BaseIF97.Basic.f3(d_liq, aux.T);
        fv := BaseIF97.Basic.f3(d_vap, aux.T);
        liq := Common.helmholtzToBoundaryProps(fl);
        vap := Common.helmholtzToBoundaryProps(fv);
        //  aux.dpT := BaseIF97.Basic.dptofT(aux.T);
      end if;
      aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d - vap.d) else BaseIF97.Basic.dptofT(aux.T);
      aux.s := liq.s + aux.x*(vap.s - liq.s);
      aux.rho := liq.d*vap.d/(vap.d + aux.x*(liq.d - vap.d));
      aux.cv := Common.cv2Phase(liq, vap, aux.x, aux.T, p);
      aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
      aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
      aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
    elseif (aux.region == 5) then
      (aux.T,error) := BaseIF97.Inverses.tofph5(p=aux.p,h= aux.h,reldh= 1.0e-7);
      assert(error == 0, "error in inverse iteration of steam tables");
      g := BaseIF97.Basic.g5(aux.p, aux.T);
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.dpT := -aux.vt/aux.vp;
    else
      assert(false, "error in region computation of IF97 steam tables"
      + "(p = " + String(p) + ", h = " + String(h) + ")");
    end if;
  end waterBaseProp_ph;

  function waterBaseProp_ps "intermediate property record for water"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Integer phase = 0
      "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    input Integer region = 0
      "if 0, do region computation, otherwise assume the region is this input";
    output Common.IF97BaseTwoPhase aux "auxiliary record";
  protected
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Integer error "error flag for inverse iterations";
    SI.SpecificEntropy s_liq "liquid specific entropy";
    SI.Density d_liq "liquid density";
    SI.SpecificEntropy s_vap "vapour specific entropy";
    SI.Density d_vap "vapour density";
    Common.PhaseBoundaryProperties liq "phase boundary property record";
    Common.PhaseBoundaryProperties vap "phase boundary property record";
    Common.GibbsDerivs gl
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.GibbsDerivs gv
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Modelica.Media.Common.HelmholtzDerivs fl
      "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
    Modelica.Media.Common.HelmholtzDerivs fv
      "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
    SI.Temperature t1
      "temperature at phase boundary, using inverse from region 1";
    SI.Temperature t2
      "temperature at phase boundary, using inverse from region 2";
  algorithm
    aux.region := if region == 0 then
      (if phase == 2 then 4 else BaseIF97.Regions.region_ps(p=p,s=s,phase=phase)) else region;
    aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
    aux.p := p;
    aux.s := s;
    aux.R := BaseIF97.data.RH2O;
    if (aux.region == 1) then
      aux.T := BaseIF97.Basic.tps1(p, s);
      g := BaseIF97.Basic.g1(p, aux.T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 0.0;
    elseif (aux.region == 2) then
      aux.T := BaseIF97.Basic.tps2(p, s);
      g := BaseIF97.Basic.g2(p, aux.T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 1.0;
    elseif (aux.region == 3) then
      (aux.rho,aux.T,error) := BaseIF97.Inverses.dtofps3(p=p,s=s,delp=1.0e-7,dels=
        1.0e-6);
      f := BaseIF97.Basic.f3(aux.rho, aux.T);
      aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta);
      aux.s := aux.R*(f.tau*f.ftau - f.f);
      aux.pd := aux.R*aux.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd);
      aux.x := 0.0;
    elseif (aux.region == 4) then
      s_liq := BaseIF97.Regions.sl_p(p);
      s_vap := BaseIF97.Regions.sv_p(p);
      aux.x := if (s_vap <> s_liq) then (s - s_liq)/(s_vap - s_liq) else 1.0;
      if p < BaseIF97.data.PLIMIT4A then
        t1 := BaseIF97.Basic.tps1(p, s_liq);
        t2 := BaseIF97.Basic.tps2(p, s_vap);
        gl := BaseIF97.Basic.g1(p, t1);
        gv := BaseIF97.Basic.g2(p, t2);
        liq := Common.gibbsToBoundaryProps(gl);
        vap := Common.gibbsToBoundaryProps(gv);
        aux.T := t1 + aux.x*(t2 - t1);
      else
        aux.T := BaseIF97.Basic.tsat(p);
        d_liq := rhol_T(aux.T);
        d_vap := rhov_T(aux.T);
        fl := BaseIF97.Basic.f3(d_liq, aux.T);
        fv := BaseIF97.Basic.f3(d_vap, aux.T);
        liq := Common.helmholtzToBoundaryProps(fl);
        vap := Common.helmholtzToBoundaryProps(fv);
      end if;
      aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d - vap.d) else
           BaseIF97.Basic.dptofT(aux.T);
      aux.h := liq.h + aux.x*(vap.h - liq.h);
      aux.rho := liq.d*vap.d/(vap.d + aux.x*(liq.d - vap.d));
      aux.cv := Common.cv2Phase(liq, vap, aux.x, aux.T, p);
      aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
      aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
      aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
    elseif (aux.region == 5) then
      (aux.T,error) := BaseIF97.Inverses.tofps5(p=p,s=s,relds= 1.0e-7);
      assert(error == 0, "error in inverse iteration of steam tables");
      g := BaseIF97.Basic.g5(p, aux.T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
    else
      assert(false, "error in region computation of IF97 steam tables"
      + "(p = " + String(p) + ", s = " + String(s) + ")");
    end if;
  end waterBaseProp_ps;

  function rho_props_ps "density as function of pressure and specific entropy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Common.IF97BaseTwoPhase properties "auxiliary record";
    output SI.Density rho "density";
  algorithm
    rho := properties.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end rho_props_ps;

  function rho_ps "density as function of pressure and specific entropy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Density rho "density";
  algorithm
    rho := rho_props_ps(p, s, waterBaseProp_ps(p, s, phase, region));
  end rho_ps;

  function T_props_ps
    "temperature as function of pressure and specific entropy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Common.IF97BaseTwoPhase properties "auxiliary record";
    output SI.Temperature T "temperature";
  algorithm
    T := properties.T;
    annotation (Inline=false,
                LateInline=true);
  end T_props_ps;

  function T_ps "temperature as function of pressure and specific entropy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Temperature T "Temperature";
  algorithm
    T := T_props_ps(p, s, waterBaseProp_ps(p, s, phase, region));
  end T_ps;

  function h_props_ps
    "specific enthalpy as function or pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := aux.h;
    annotation (
      Inline=false,
      LateInline=true);
  end h_props_ps;

  function h_ps "specific enthalpy as function or pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := h_props_ps(p, s, waterBaseProp_ps(p, s, phase, region));
  end h_ps;

  function phase_ps "phase as a function of  pressure and specific entropy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    output Integer phase "true if in liquid or gas or supercritical region";
  algorithm
    phase := if ((s < sl_p(p) or s > sv_p(p)) or p > BaseIF97.data.PCRIT) then 1 else 2;
    annotation (InlineNoEvent=false);
  end phase_ps;

  function phase_ph "phase as a function of  pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    output Integer phase "true if in liquid or gas or supercritical region";
  algorithm
    phase := if ((h < hl_p(p) or h > hv_p(p)) or p > BaseIF97.data.PCRIT) then 1 else 2;
    annotation (InlineNoEvent=false);
  end phase_ph;

  function phase_dT "phase as a function of  pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Density rho "density";
    input SI.Temperature T "temperature";
    output Integer phase "true if in liquid or gas or supercritical region";
  algorithm
    phase := if not ((rho < rhol_T(T) and rho > rhov_T(T)) and T < BaseIF97.
      data.TCRIT) then 1 else 2;
    annotation (InlineNoEvent=false);
  end phase_dT;

  function rho_props_ph "density as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase properties "auxiliary record";
    output SI.Density rho "density";
  algorithm
    rho := properties.rho;
    annotation (
      derivative(noDerivative=properties) = rho_ph_der,
      Inline=false,
      LateInline=true);
  end rho_props_ph;

  function rho_ph "density as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Density rho "density";
  algorithm
    rho := rho_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end rho_ph;

  function rho_ph_der "derivative function of rho_ph"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real p_der "derivative of pressure";
    input Real h_der "derivative of specific enthalpy";
    output Real rho_der "derivative of density";
  algorithm
    if (aux.region == 4) then
      rho_der := (aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T))*p_der
         + (-aux.rho*aux.rho/(aux.dpT*aux.T))*h_der;
    elseif (aux.region == 3) then
      rho_der := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*
        aux.cv + aux.T*aux.pt*aux.pt))*p_der + (-aux.rho*aux.rho*aux.pt/(aux.
        rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
    else
      //regions 1,2,5
      rho_der := (-aux.rho*aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.
        vt*aux.vt)/aux.cp)*p_der + (-aux.rho*aux.rho*aux.vt/(aux.cp))*h_der;
    end if;
  end rho_ph_der;

  function T_props_ph
    "temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase properties "auxiliary record";
    output SI.Temperature T "temperature";
  algorithm
    T := properties.T;
    annotation (derivative(noDerivative=properties) = T_ph_der,
      Inline=false,
      LateInline=true);
  end T_props_ph;

  function T_ph "temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Temperature T "Temperature";
  algorithm
    T := T_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end T_ph;

  function T_ph_der "derivative function of T_ph"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real p_der "derivative of pressure";
    input Real h_der "derivative of specific enthalpy";
    output Real T_der "derivative of temperature";
  algorithm
    if (aux.region == 4) then
      T_der := 1/aux.dpT*p_der;
    elseif (aux.region == 3) then
      T_der := ((-aux.rho*aux.pd + aux.T*aux.pt)/(aux.rho*aux.rho*aux.pd*aux.cv
         + aux.T*aux.pt*aux.pt))*p_der + ((aux.rho*aux.rho*aux.pd)/(aux.rho*aux.
         rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
    else
      //regions 1,2 or 5
      T_der := ((-1/aux.rho + aux.T*aux.vt)/aux.cp)*p_der + (1/aux.cp)*h_der;
    end if;
  end T_ph_der;

  function s_props_ph
    "specific entropy as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase properties "auxiliary record";
    output SI.SpecificEntropy s "specific entropy";
  algorithm
    s := properties.s;
    annotation (derivative(noDerivative=properties) = s_ph_der,
  Inline=false,
  LateInline=true);
  end s_props_ph;

  function s_ph
    "specific entropy as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase =   0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEntropy s "specific entropy";
  algorithm
    s := s_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end s_ph;

  function s_ph_der
    "specific entropy as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real p_der "derivative of pressure";
    input Real h_der "derivative of specific enthalpy";
    output Real s_der "derivative of entropy";
  algorithm
    s_der := -1/(aux.rho*aux.T)*p_der + 1/aux.T*h_der;
  end s_ph_der;

  function cv_props_ph
    "specific heat capacity at constant volume as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificHeatCapacity cv "specific heat capacity";
  algorithm
    cv := aux.cv;
    annotation (
      Inline=false,
      LateInline=true);
  end cv_props_ph;

  function cv_ph
    "specific heat capacity at constant volume as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificHeatCapacity cv "specific heat capacity";
  algorithm
    cv := cv_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end cv_ph;

  function regionAssertReal "assert function for inlining"
    extends Modelica.Icons.Function;
    input Boolean check "condition to check";
    output Real dummy "dummy output";
  algorithm
    assert(check, "this function can not be called with two-phase inputs!");
  end regionAssertReal;

  function cp_props_ph
    "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificHeatCapacity cp "specific heat capacity";
  algorithm
    cp := aux.cp;
    annotation (
      Inline=false,
      LateInline=true);
  end cp_props_ph;

  function cp_ph
    "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificHeatCapacity cp "specific heat capacity";
  algorithm
    cp := cp_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end cp_ph;

  function beta_props_ph
    "isobaric expansion coefficient as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
  algorithm
    beta := if aux.region == 3 or aux.region == 4 then
      aux.pt/(aux.rho*aux.pd) else
      aux.vt*aux.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end beta_props_ph;

  function beta_ph
    "isobaric expansion coefficient as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
  algorithm
    beta := beta_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end beta_ph;

  function kappa_props_ph
    "isothermal compressibility factor as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.IsothermalCompressibility kappa
      "isothermal compressibility factor";
  algorithm
    kappa := if aux.region == 3 or aux.region == 4 then
      1/(aux.rho*aux.pd) else -aux.vp*aux.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end kappa_props_ph;

  function kappa_ph
    "isothermal compressibility factor as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.IsothermalCompressibility kappa
      "isothermal compressibility factor";
  algorithm
    kappa := kappa_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end kappa_ph;

  function velocityOfSound_props_ph
    "speed of sound as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.Velocity v_sound "speed of sound";
  algorithm
    // dp/drho at constant s
    v_sound := if aux.region == 3 then sqrt(max(0,(aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv))) else
      if aux.region == 4 then
      sqrt(max(0,1/((aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T)) - 1/aux.rho*aux.rho*aux.rho/(aux.dpT*aux.T)))) else
           sqrt(max(0,-aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp+aux.vt*aux.vt*aux.T))));
    annotation (
      Inline=false,
      LateInline=true);
  end velocityOfSound_props_ph;

  function velocityOfSound_ph
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Velocity v_sound "speed of sound";
  algorithm
    v_sound := velocityOfSound_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
  end velocityOfSound_ph;

  function isentropicExponent_props_ph
    "isentropic exponent as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output Real gamma "isentropic exponent";
  algorithm
    gamma := if aux.region == 3 then 1/(aux.rho*p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt*aux.T)/(aux.cv)) else
           if aux.region == 4 then 1/(aux.rho*p)*aux.dpT*aux.dpT*aux.T/aux.cv else
      -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
    annotation (
      Inline=false,
      LateInline=true);
  end isentropicExponent_props_ph;

  function isentropicExponent_ph
    "isentropic exponent as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase =   0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output Real gamma "isentropic exponent";
  algorithm
    gamma := isentropicExponent_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
    annotation (
      Inline=false,
      LateInline=true);
  end isentropicExponent_ph;

  function ddph_props "density derivative by pressure"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.DerDensityByPressure ddph "density derivative by pressure";
  algorithm
    ddph := if aux.region == 3 then
      ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)) else
      if aux.region == 4 then  (aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T)) else
           (-aux.rho*aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt*aux.vt)/aux.cp);
    annotation (
      Inline=false,
      LateInline=true);
  end ddph_props;

  function ddph "density derivative by pressure"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.DerDensityByPressure ddph "density derivative by pressure";
  algorithm
    ddph := ddph_props(p, h, waterBaseProp_ph(p, h, phase, region));
  end ddph;

  function ddhp_props "density derivative by specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.DerDensityByEnthalpy ddhp
      "density derivative by specific enthalpy";
  algorithm
    ddhp := if aux.region == 3 then
      -aux.rho*aux.rho*aux.pt/(aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt) else
      if aux.region == 4 then -aux.rho*aux.rho/(aux.dpT*aux.T) else
           -aux.rho*aux.rho*aux.vt/(aux.cp);
    annotation (
      Inline=false,
      LateInline=true);
  end ddhp_props;

  function ddhp "density derivative by specific enthalpy"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEnthalpy h "specific enthalpy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.DerDensityByEnthalpy ddhp
      "density derivative by specific enthalpy";
  algorithm
    ddhp := ddhp_props(p, h, waterBaseProp_ph(p, h, phase, region));
  end ddhp;

  function waterBaseProp_pT
    "intermediate property record for water (p and T prefered states)"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region = 0
      "if 0, do region computation, otherwise assume the region is this input";
    output Common.IF97BaseTwoPhase aux "auxiliary record";
  protected
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Integer error "error flag for inverse iterations";
  algorithm
    aux.phase := 1;
    aux.region := if region == 0 then BaseIF97.Regions.region_pT(p=p,T= T) else region;
    aux.R := BaseIF97.data.RH2O;
    aux.p := p;
    aux.T := T;
    if (aux.region == 1) then
      g := BaseIF97.Basic.g1(p, T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := p/(aux.R*T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 0.0;
    elseif (aux.region == 2) then
      g := BaseIF97.Basic.g2(p, T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := p/(aux.R*T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 1.0;
    elseif (aux.region == 3) then
      (aux.rho,error) := BaseIF97.Inverses.dofpt3(p=p,T= T,delp= 1.0e-7);
      f := BaseIF97.Basic.f3(aux.rho, T);
      aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta);
      aux.s := aux.R*(f.tau*f.ftau - f.f);
      aux.pd := aux.R*T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.x := 0.0;
    elseif (aux.region == 5) then
      g := BaseIF97.Basic.g5(p, T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := p/(aux.R*T*g.pi*g.gpi);
      aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
    else
      assert(false, "error in region computation of IF97 steam tables"
       + "(p = " + String(p) + ", T = " + String(T) + ")");
    end if;
  end waterBaseProp_pT;

  function rho_props_pT "density as function or pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.Density rho "density";
  algorithm
    rho := aux.rho;
    annotation (
      derivative(noDerivative=aux) = rho_pT_der,
      Inline=false,
      LateInline=true);
  end rho_props_pT;

  function rho_pT "density as function or pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Density rho "density";
  algorithm
    rho := rho_props_pT(p, T, waterBaseProp_pT(p, T, region));
  end rho_pT;

  function h_props_pT
    "specific enthalpy as function or pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := aux.h;
    annotation (
      derivative(noDerivative=aux) = h_pT_der,
      Inline=false,
      LateInline=true);
  end h_props_pT;

  function h_pT "specific enthalpy as function or pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "Temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := h_props_pT(p, T, waterBaseProp_pT(p, T, region));
  end h_pT;

  function h_pT_der "derivative function of h_pT"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real p_der "derivative of pressure";
    input Real T_der "derivative of temperature";
    output Real h_der "derivative of specific enthalpy";
  algorithm
    if (aux.region == 3) then
      h_der := ((-aux.rho*aux.pd + T*aux.pt)/(aux.rho*aux.rho*aux.pd))*p_der +
        ((aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho
        *aux.pd))*T_der;
    else
      //regions 1,2 or 5
      h_der := (1/aux.rho - aux.T*aux.vt)*p_der + aux.cp*T_der;
    end if;
  end h_pT_der;

  function rho_pT_der "derivative function of rho_pT"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real p_der "derivative of pressure";
    input Real T_der "derivative of temperature";
    output Real rho_der "derivative of density";
  algorithm
    if (aux.region == 3) then
      rho_der := (1/aux.pd)*p_der - (aux.pt/aux.pd)*T_der;
    else
      //regions 1,2 or 5
      rho_der := (-aux.rho*aux.rho*aux.vp)*p_der + (-aux.rho*aux.rho*aux.vt)*
        T_der;
    end if;
  end rho_pT_der;

  function s_props_pT
    "specific entropy as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificEntropy s "specific entropy";
  algorithm
    s := aux.s;
    annotation (
      Inline=false,
      LateInline=true);
  end s_props_pT;

  function s_pT "temperature as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEntropy s "specific entropy";
  algorithm
    s := s_props_pT(p, T, waterBaseProp_pT(p, T, region));
    annotation (InlineNoEvent=false);
  end s_pT;

  function cv_props_pT
    "specific heat capacity at constant volume as function of pressure and temperature"

    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificHeatCapacity cv "specific heat capacity";
  algorithm
    cv := aux.cv;
    annotation (
      Inline=false,
      LateInline=true);
  end cv_props_pT;

  function cv_pT
    "specific heat capacity at constant volume as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificHeatCapacity cv "specific heat capacity";
  algorithm
    cv := cv_props_pT(p, T, waterBaseProp_pT(p, T, region));
    annotation (InlineNoEvent=false);
  end cv_pT;

  function cp_props_pT
    "specific heat capacity at constant pressure as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificHeatCapacity cp "specific heat capacity";
  algorithm
    cp := if aux.region == 3 then
      (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd) else
      aux.cp;
    annotation (
      Inline=false,
      LateInline=true);
  end cp_props_pT;

  function cp_pT
    "specific heat capacity at constant pressure as function of pressure and temperature"

    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificHeatCapacity cp "specific heat capacity";
  algorithm
    cp := cp_props_pT(p, T, waterBaseProp_pT(p, T, region));
    annotation (InlineNoEvent=false);
  end cp_pT;

  function beta_props_pT
    "isobaric expansion coefficient as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
  algorithm
    beta := if aux.region == 3 then
      aux.pt/(aux.rho*aux.pd) else
      aux.vt*aux.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end beta_props_pT;

  function beta_pT
    "isobaric expansion coefficient as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
  algorithm
    beta := beta_props_pT(p, T, waterBaseProp_pT(p, T, region));
    annotation (InlineNoEvent=false);
  end beta_pT;

  function kappa_props_pT
    "isothermal compressibility factor as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.IsothermalCompressibility kappa
      "isothermal compressibility factor";
  algorithm
    kappa := if aux.region == 3 then
      1/(aux.rho*aux.pd) else -aux.vp*aux.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end kappa_props_pT;

  function kappa_pT
    "isothermal compressibility factor as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.IsothermalCompressibility kappa
      "isothermal compressibility factor";
  algorithm
    kappa := kappa_props_pT(p, T, waterBaseProp_pT(p, T, region));
    annotation (InlineNoEvent=false);
  end kappa_pT;

  function velocityOfSound_props_pT
    "speed of sound as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.Velocity v_sound "speed of sound";
  algorithm
    // dp/drho at constant s
    v_sound := if aux.region == 3 then sqrt(max(0,(aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv))) else
      sqrt(max(0,-aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp+aux.vt*aux.vt*aux.T))));
    annotation (
      Inline=false,
      LateInline=true);
  end velocityOfSound_props_pT;

  function velocityOfSound_pT
    "speed of sound as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Velocity v_sound "speed of sound";
  algorithm
    v_sound := velocityOfSound_props_pT(p, T, waterBaseProp_pT(p, T, region));
  end velocityOfSound_pT;

  function isentropicExponent_props_pT
    "isentropic exponent as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output Real gamma "isentropic exponent";
  algorithm
    gamma := if aux.region == 3 then 1/(aux.rho*p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt*aux.T)/(aux.cv)) else
      -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
    annotation (
      Inline=false,
      LateInline=true);
  end isentropicExponent_props_pT;

  function isentropicExponent_pT
    "isentropic exponent as function of pressure and temperature"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.Temperature T "temperature";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output Real gamma "isentropic exponent";
  algorithm
    gamma := isentropicExponent_props_pT(p, T, waterBaseProp_pT(p, T, region));
    annotation (
      Inline=false,
      LateInline=true);
  end isentropicExponent_pT;

  function waterBaseProp_dT
    "intermediate property record for water (d and T prefered states)"
    extends Modelica.Icons.Function;
    input SI.Density rho "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0
      "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    input Integer region = 0
      "if 0, do region computation, otherwise assume the region is this input";
    output Common.IF97BaseTwoPhase aux "auxiliary record";
  protected
    SI.SpecificEnthalpy h_liq "liquid specific enthalpy";
    SI.Density d_liq "liquid density";
    SI.SpecificEnthalpy h_vap "vapour specific enthalpy";
    SI.Density d_vap "vapour density";
    Common.GibbsDerivs g
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Common.HelmholtzDerivs f
      "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    Modelica.Media.Common.PhaseBoundaryProperties liq
      "phase boundary property record";
    Modelica.Media.Common.PhaseBoundaryProperties vap
      "phase boundary property record";
    Modelica.Media.Common.GibbsDerivs gl
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Modelica.Media.Common.GibbsDerivs gv
      "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
    Modelica.Media.Common.HelmholtzDerivs fl
      "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
    Modelica.Media.Common.HelmholtzDerivs fv
      "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
    Integer error "error flag for inverse iterations";
  algorithm
    aux.region := if region == 0 then
      (if phase == 2 then 4 else BaseIF97.Regions.region_dT(d=rho,T= T,phase= phase)) else region;
    aux.phase := if aux.region == 4 then 2 else 1;
    aux.R := BaseIF97.data.RH2O;
    aux.rho := rho;
    aux.T := T;
    if (aux.region == 1) then
      (aux.p,error) := BaseIF97.Inverses.pofdt125(d=rho,T= T,reldd= 1.0e-8,region=
               1);
      g := BaseIF97.Basic.g1(aux.p, T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
      aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 0.0;
    elseif (aux.region == 2) then
      (aux.p,error) := BaseIF97.Inverses.pofdt125(d=rho,T= T,reldd= 1.0e-8,region=
               2);
      g := BaseIF97.Basic.g2(aux.p, T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
      aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
      aux.x := 1.0;
    elseif (aux.region == 3) then
      f := BaseIF97.Basic.f3(rho, T);
      aux.p := aux.R*rho*T*f.delta*f.fdelta;
      aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta);
      aux.s := aux.R*(f.tau*f.ftau - f.f);
      aux.pd := aux.R*T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho*aux.pd);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.x := 0.0;
    elseif (aux.region == 4) then
      aux.p := BaseIF97.Basic.psat(T);
      d_liq := rhol_T(T);
      d_vap := rhov_T(T);
      h_liq := hl_p(aux.p);
      h_vap := hv_p(aux.p);
      aux.x := if (d_vap <> d_liq) then (1/rho - 1/d_liq)/(1/d_vap - 1/d_liq) else
      1.0;
      aux.h := h_liq + aux.x*(h_vap - h_liq);
      if T < BaseIF97.data.TLIMIT1 then
        gl := BaseIF97.Basic.g1(aux.p, T);
        gv := BaseIF97.Basic.g2(aux.p, T);
        liq := Common.gibbsToBoundaryProps(gl);
        vap := Common.gibbsToBoundaryProps(gv);
      else
        fl := BaseIF97.Basic.f3(d_liq, T);
        fv := BaseIF97.Basic.f3(d_vap, T);
        liq := Common.helmholtzToBoundaryProps(fl);
        vap := Common.helmholtzToBoundaryProps(fv);
      end if;
      aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d - vap.d) else BaseIF97.Basic.dptofT(aux.T);
      aux.s := liq.s + aux.x*(vap.s - liq.s);
      aux.cv := Common.cv2Phase(liq, vap, aux.x, aux.T, aux.p);
      aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
      aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
      aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
    elseif (aux.region == 5) then
      (aux.p,error) := BaseIF97.Inverses.pofdt125(d=rho,T= T,reldd= 1.0e-8,region=5);
      g := BaseIF97.Basic.g2(aux.p, T);
      aux.h := aux.R*aux.T*g.tau*g.gtau;
      aux.s := aux.R*(g.tau*g.gtau - g.g);
      aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
      aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
      aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
      aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/g.gpipi));
    else
      assert(false, "error in region computation of IF97 steam tables"
       + "(rho = " + String(rho) + ", T = " + String(T) + ")");
    end if;
  end waterBaseProp_dT;

  function h_props_dT
    "specific enthalpy as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "Temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := aux.h;
    annotation (
      derivative(noDerivative=aux) = h_dT_der,
      Inline=false,
      LateInline=true);
  end h_props_dT;

  function h_dT "specific enthalpy as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "Temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := h_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end h_dT;

  function h_dT_der "derivative function of h_dT"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real d_der "derivative of density";
    input Real T_der "derivative of temperature";
    output Real h_der "derivative of specific enthalpy";
  algorithm
    if (aux.region == 3) then
      h_der := ((-d*aux.pd + T*aux.pt)/(d*d))*d_der + ((aux.cv*d + aux.pt)/d)*
        T_der;
    elseif (aux.region == 4) then
      h_der := T*aux.dpT/(d*d)*d_der + ((aux.cv*d + aux.dpT)/d)*T_der;
    else
      //regions 1,2 or 5
      h_der := (-(-1/d + T*aux.vt)/(d*d*aux.vp))*d_der + ((aux.vp*aux.cp - aux.
        vt/d + T*aux.vt*aux.vt)/aux.vp)*T_der;
    end if;
  end h_dT_der;

  function p_props_dT "pressure as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "Temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.Pressure p "pressure";
  algorithm
    p := aux.p;
    annotation (
      derivative(noDerivative=aux) = p_dT_der,
      Inline=false,
      LateInline=true);
  end p_props_dT;

  function p_dT "pressure as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "Temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Pressure p "pressure";
  algorithm
    p := p_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end p_dT;

  function p_dT_der "derivative function of p_dT"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real d_der "derivative of density";
    input Real T_der "derivative of temperature";
    output Real p_der "derivative of pressure";
  algorithm
    if (aux.region == 3) then
      p_der := aux.pd*d_der + aux.pt*T_der;
    elseif (aux.region == 4) then
      p_der := aux.dpT*T_der;
      /*density derivative is 0.0*/
    else
      //regions 1,2 or 5
      p_der := (-1/(d*d*aux.vp))*d_der + (-aux.vt/aux.vp)*T_der;
    end if;
  end p_dT_der;

  function s_props_dT "specific entropy as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "Temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificEntropy s "specific entropy";
  algorithm
    s := aux.s;
    annotation (
      Inline=false,
      LateInline=true);
  end s_props_dT;

  function s_dT "temperature as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "Temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEntropy s "specific entropy";
  algorithm
    s := s_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end s_dT;

  function cv_props_dT
    "specific heat capacity at constant volume as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificHeatCapacity cv "specific heat capacity";
  algorithm
    cv := aux.cv;
    annotation (
      Inline=false,
      LateInline=true);
  end cv_props_dT;

  function cv_dT
    "specific heat capacity at constant volume as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificHeatCapacity cv "specific heat capacity";
  algorithm
    cv := cv_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end cv_dT;

  function cp_props_dT
    "specific heat capacity at constant pressure as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificHeatCapacity cp "specific heat capacity";
  algorithm
    cp := aux.cp;
    annotation (
      Inline=false,
      LateInline=true);
  end cp_props_dT;

  function cp_dT
    "specific heat capacity at constant pressure as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificHeatCapacity cp "specific heat capacity";
  algorithm
    cp := cp_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end cp_dT;

  function beta_props_dT
    "isobaric expansion coefficient as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
  algorithm
    beta := if aux.region == 3 or aux.region == 4 then
      aux.pt/(aux.rho*aux.pd) else
      aux.vt*aux.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end beta_props_dT;

  function beta_dT
    "isobaric expansion coefficient as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
  algorithm
    beta := beta_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end beta_dT;

  function kappa_props_dT
    "isothermal compressibility factor as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.IsothermalCompressibility kappa
      "isothermal compressibility factor";
  algorithm
    kappa := if aux.region == 3 or aux.region == 4 then
      1/(aux.rho*aux.pd) else -aux.vp*aux.rho;
    annotation (
      Inline=false,
      LateInline=true);
  end kappa_props_dT;

  function kappa_dT
    "isothermal compressibility factor as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.IsothermalCompressibility kappa
      "isothermal compressibility factor";
  algorithm
    kappa := kappa_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end kappa_dT;

  function velocityOfSound_props_dT
    "speed of sound as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.Velocity v_sound "speed of sound";
  algorithm
    // dp/drho at constant s
    v_sound := if aux.region == 3 then sqrt(max(0,((aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv)))) else
      if aux.region == 4 then
      sqrt(max(0,1/((aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T)) - 1/aux.rho*aux.rho*aux.rho/(aux.dpT*aux.T)))) else
           sqrt(max(0,-aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp+aux.vt*aux.vt*aux.T))));
    annotation (
      Inline=false,
      LateInline=true);
  end velocityOfSound_props_dT;

  function velocityOfSound_dT
    "speed of sound as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output SI.Velocity v_sound "speed of sound";
  algorithm
    v_sound := velocityOfSound_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
  end velocityOfSound_dT;

  function isentropicExponent_props_dT
    "isentropic exponent as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output Real gamma "isentropic exponent";
  algorithm
    gamma := if aux.region == 3 then 1/(aux.rho*aux.p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt*aux.T)/(aux.cv)) else
           if aux.region == 4 then 1/(aux.rho*aux.p)*aux.dpT*aux.dpT*aux.T/aux.cv else
      -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
    annotation (
      Inline=false,
      LateInline=true);
  end isentropicExponent_props_dT;

  function isentropicExponent_dT
    "isentropic exponent as function of density and temperature"
    extends Modelica.Icons.Function;
    input SI.Density d "density";
    input SI.Temperature T "temperature";
    input Integer phase =  0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region =  0
      "if 0, region is unknown, otherwise known and this input";
    output Real gamma "isentropic exponent";
  algorithm
    gamma := isentropicExponent_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
    annotation (
      Inline=false,
      LateInline=true);
  end isentropicExponent_dT;

protected
  package ThermoFluidSpecial
    function water_ph
      "calculate the property record for dynamic simulation properties using p,h as states"
      extends Modelica.Icons.Function;
      input SI.Pressure p "pressure";
      input SI.SpecificEnthalpy h "specific enthalpy";
      input Integer phase= 0
        "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
      output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_ph pro
        "property record for dynamic simulation";
    protected
      Modelica.Media.Common.GibbsDerivs g
        "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
      Integer region(min=1, max=5) "IF97 region";
      Integer error "error flag";
      SI.Temperature T "temperature";
      SI.Density d "density";
    algorithm
      region := BaseIF97.Regions.region_ph(p, h, phase);
      if (region == 1) then
        T := BaseIF97.Basic.tph1(p, h);
        g := BaseIF97.Basic.g1(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_ph(g);
      elseif (region == 2) then
        T := BaseIF97.Basic.tph2(p, h);
        g := BaseIF97.Basic.g2(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_ph(g);
      elseif (region == 3) then
        (d,T,error) := BaseIF97.Inverses.dtofph3(p=p,h= h,delp= 1.0e-7,delh=
          1.0e-6);
        f := BaseIF97.Basic.f3(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_ph(f);
      elseif (region == 4) then
        pro := BaseIF97.TwoPhase.waterR4_ph(p=p,h= h);
      elseif (region == 5) then
        (T,error) := BaseIF97.Inverses.tofph5(p=p,h= h,reldh= 1.0e-7);
        g := BaseIF97.Basic.g5(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_ph(g);
      end if;
    end water_ph;

    function water_dT
      "calculate property record for dynamic simulation properties using d and T as dynamic states"
      extends Modelica.Icons.Function;
      input SI.Density d "density";
      input SI.Temperature T "temperature";
      input Integer phase= 0
        "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
      output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_dT pro
        "property record for dynamic simulation";
    protected
      SI.Pressure p "pressure";
      Integer region(min=1, max=5) "IF97 region";
      Modelica.Media.Common.GibbsDerivs g
        "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
      Integer error "error flag";
    algorithm
      region := BaseIF97.Regions.region_dT(d, T, phase);
      if (region == 1) then
        (p,error) := BaseIF97.Inverses.pofdt125(d=d,T= T,reldd= iter.DELD,region=
                 1);
        g := BaseIF97.Basic.g1(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_dT(g);
      elseif (region == 2) then
        (p,error) := BaseIF97.Inverses.pofdt125(d=d,T= T,reldd= iter.DELD,region=
                 2);
        g := BaseIF97.Basic.g2(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_dT(g);
      elseif (region == 3) then
        f := BaseIF97.Basic.f3(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
      elseif (region == 4) then
        pro := BaseIF97.TwoPhase.waterR4_dT(d=d,T= T);
      elseif (region == 5) then
        (p,error) := BaseIF97.Inverses.pofdt125(d=d,T= T,reldd= iter.DELD,region=
                 5);
        g := BaseIF97.Basic.g5(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_dT(g);
      end if;
    end water_dT;

    function water_pT
      "calculate property record for dynamic simulation properties using p and T as dynamic states"

      extends Modelica.Icons.Function;
      input SI.Pressure p "pressure";
      input SI.Temperature T "temperature";
      output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT pro
        "property record for dynamic simulation";
    protected
      SI.Density d "density";
      Integer region(min=1, max=5) "IF97 region";
      Modelica.Media.Common.GibbsDerivs g
        "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
      Integer error "error flag";
    algorithm
      region := BaseIF97.Regions.region_pT(p, T);
      if (region == 1) then
        g := BaseIF97.Basic.g1(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_pT(g);
      elseif (region == 2) then
        g := BaseIF97.Basic.g2(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_pT(g);
      elseif (region == 3) then
        (d,error) := BaseIF97.Inverses.dofpt3(p=p,T= T,delp= iter.DELP);
        f := BaseIF97.Basic.f3(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_pT(f);
      elseif (region == 5) then
        g := BaseIF97.Basic.g5(p, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.gibbsToProps_pT(g);
      end if;
    end water_pT;
  end ThermoFluidSpecial;

public
  function hl_p = BaseIF97.Regions.hl_p
    "compute the saturated liquid specific h(p)";
  function hv_p = BaseIF97.Regions.hv_p
    "compute the saturated vapour specific h(p)";

  function sl_p = BaseIF97.Regions.sl_p
    "compute the saturated liquid specific s(p)";
  function sv_p = BaseIF97.Regions.sv_p
    "compute the saturated vapour specific s(p)";

  function rhol_T = BaseIF97.Regions.rhol_T "compute the saturated liquid d(T)";
  function rhov_T = BaseIF97.Regions.rhov_T "compute the saturated vapour d(T)";

  function rhol_p = BaseIF97.Regions.rhol_p "compute the saturated liquid d(p)";
  function rhov_p = BaseIF97.Regions.rhov_p "compute the saturated vapour d(p)";

  function dynamicViscosity = BaseIF97.Transport.visc_dTp
    "compute eta(d,T) in the one-phase region";
  function thermalConductivity = BaseIF97.Transport.cond_dTp
    "compute lambda(d,T,p) in the one-phase region";
  function surfaceTension = BaseIF97.Transport.surfaceTension
    "compute sigma(T) at saturation T";

//   function isentropicEnthalpy
//     "isentropic specific enthalpy from p,s (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)"
//     extends Modelica.Icons.Function;
//     input SI.Pressure p "pressure";
//     input SI.SpecificEntropy s "specific entropy";
//     input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
//     output SI.SpecificEnthalpy h "specific enthalpy";
//   algorithm
//    h := BaseIF97.Isentropic.water_hisentropic(p,s,phase);
//   end isentropicEnthalpy;

  function isentropicEnthalpy
    "isentropic specific enthalpy from p,s (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region = 0
      "if 0, region is unknown, otherwise known and this input";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := isentropicEnthalpy_props(p, s, waterBaseProp_ps(p, s, phase, region));
  end isentropicEnthalpy;

  function isentropicEnthalpy_props
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    output SI.SpecificEnthalpy h "isentropic enthalpay";
  algorithm
    h := aux.h;
    annotation (derivative(noDerivative=aux) = isentropicEnthalpy_der,
  Inline=false,
  LateInline=true);
  end isentropicEnthalpy_props;

  function isentropicEnthalpy_der
    "derivative of isentropic specific enthalpy from p,s"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input Common.IF97BaseTwoPhase aux "auxiliary record";
    input Real p_der "pressure derivative";
    input Real s_der "entropy derivative";
    output Real h_der "specific enthalpy derivative";
  algorithm
    h_der := 1/aux.rho*p_der + aux.T*s_der;
  end isentropicEnthalpy_der;

  function dynamicIsentropicEnthalpy
    "isentropic specific enthalpy from p,s and good guesses of d and T"
    extends Modelica.Icons.Function;
    input SI.Pressure p "pressure";
    input SI.SpecificEntropy s "specific entropy";
    input SI.Density dguess "good guess density, e.g., from adjacent volume";
    input SI.Temperature Tguess
      "good guess temperature, e.g., from adjacent volume";
    input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SI.SpecificEnthalpy h "specific enthalpy";
  algorithm
   h := BaseIF97.Isentropic.water_hisentropic_dyn(p,s,dguess,Tguess,0);
  end dynamicIsentropicEnthalpy;

  annotation (Documentation(info="<HTML>
      <h4>Package description:</h4>
      <p>This package provides high accuracy physical properties for water according
      to the IAPWS/IF97 standard. It has been part of the ThermoFluid Modelica library and been extended,
      reorganized and documented to become part of the Modelica Standard library.</p>
      <p>An important feature that distinguishes this implementation of the IF97 steam property standard
      is that this implementation has been explicitly designed to work well in dynamic simulations. Computational
      performance has been of high importance. This means that there often exist several ways to get the same result
      from different functions if one of the functions is called often but can be optimized for that purpose.
   </p>
      <p>
      The original documentation of the IAPWS/IF97 steam properties can freely be distributed with computer
      implementations, so for curious minds the complete standard documentation is provided with the Modelica
      properties library. The following documents are included
      (in directory Modelica/Resources/Documentation/IF97documentation):
      <ul>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (in IF97_Utilities.BaseIF97.IceBoundaries)</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
      </ul>
   </p>
      <h4>Package contents
      </h4>
      <p>
      <ul>
      <li>Package <b>BaseIF97</b> contains the implementation of the IAPWS-IF97 as described in
      <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a>. The explicit backwards equations for region 3 from
      <a href=\"modelica://Modelica/Resources/Documentation/IF97documentation/Back3.pdf\">Back3.pdf</a> are implemented as initial values for an inverse iteration of the exact
      function in IF97 for the input pairs (p,h) and (p,s).
      The low-level functions in BaseIF97 are not needed for standard simulation usage,
      but can be useful for experts and some special purposes.</li>
      <li>Function <b>water_ph</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and specific entropy enthalpy h as dynamic states in the record ThermoProperties_ph. </li>
      <li>Function <b>water_ps</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and specific entropy s as dynamic states in the record ThermoProperties_ps. </li>
      <li>Function <b>water_dT</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using density d and temperature T as dynamic states in the record ThermoProperties_dT. </li>
      <li>Function <b>water_pT</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and temperature T as dynamic states in the record ThermoProperties_pT. Due to the coupling of
      pressure and temperature in the two-phase region, this model can obviously
      only be used for one-phase models or models treating both phases independently.</li>
      <li>Function <b>hl_p</b> computes the liquid specific enthalpy as a function of pressure. For overcritical pressures,
      the critical specific enthalpy is returned</li>
      <li>Function <b>hv_p</b> computes the vapour specific enthalpy as a function of pressure. For overcritical pressures,
      the critical specific enthalpy is returned</li>
      <li>Function <b>sl_p</b> computes the liquid specific entropy as a function of pressure. For overcritical pressures,
      the critical  specific entropy is returned</li>
      <li>Function <b>sv_p</b> computes the vapour  specific entropy as a function of pressure. For overcritical pressures,
      the critical  specific entropyis returned</li>
      <li>Function <b>rhol_T</b> computes the liquid density as a function of temperature. For overcritical temperatures,
      the critical density is returned</li>
      <li>Function <b>rhol_T</b> computes the vapour density as a function of temperature. For overcritical temperatures,
      the critical density is returned</li>
      <li>Function <b>dynamicViscosity</b> computes the dynamic viscosity as a function of density and temperature.</li>
      <li>Function <b>thermalConductivity</b> computes the thermal conductivity as a function of density, temperature and pressure.
      <b>Important note</b>: Obviously only two of the three
      inputs are really needed, but using three inputs speeds up the computation and the three variables
      are known in most models anyways. The inputs d,T and p have to be consistent.</li>
      <li>Function <b>surfaceTension</b> computes the surface tension between vapour
          and liquid water as a function of temperature.</li>
      <li>Function <b>isentropicEnthalpy</b> computes the specific enthalpy h(p,s,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary.</li>
      <li>Function <b>dynamicIsentropicEnthalpy</b> computes the specific enthalpy h(p,s,,dguess,Tguess,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary. Tguess and dguess are initial guess
          values for the density and temperature consistent with p and s. This function should be preferred in
          dynamic simulations where good guesses are often available.</li>
      </ul>
   </p>
      <h4>Version Info and Revision history
      </h4>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by Hubertus Tummescheit for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions:   <i>December, 2002</i>
      by <a href=\"mailto:Hubertus.Tummescheit@modelon.se\">Hubertus Tummescheit</a> and moved to Modelica
      properties library.</li>
      </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
      </address>
      </HTML>", revisions="<h4>Intermediate release notes during development</h4>
<p>Currenly the Events/noEvents switch is only implmented for p-h states. Only after testing that implmentation, it will be extended to dT.</p>"));
end IF97_Utilities;
