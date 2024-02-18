# GitHub issues resolved for v4.1.0

As part of this release 414 [issues](https://github.com/modelica/ModelicaStandardLibrary/milestone/61) (including 312 pull requests (PR)) were closed.

## --MSL-general--

### Enhancements

* [\#4094](https://github.com/modelica/ModelicaStandardLibrary/pull/4094) (PR) First figure

### Documentation

* [\#3552](https://github.com/modelica/ModelicaStandardLibrary/pull/3552) (PR) Add division tag around image tags
* [\#3673](https://github.com/modelica/ModelicaStandardLibrary/pull/3673) (PR) Update DLR contact address
* [\#3745](https://github.com/modelica/ModelicaStandardLibrary/pull/3745) (PR) Update DLR contact link
* [\#4136](https://github.com/modelica/ModelicaStandardLibrary/pull/4136) (PR) Unify spelling of controllers
* [\#4196](https://github.com/modelica/ModelicaStandardLibrary/pull/4196) (PR) Fix and add ITEA links
* [\#4208](https://github.com/modelica/ModelicaStandardLibrary/pull/4208) (PR) Bump used Modelica language version to 3.6

### Miscellaneous

* [\#3639](https://github.com/modelica/ModelicaStandardLibrary/pull/3639) (PR) Fix missing include in Common.c (CI)
* [\#3642](https://github.com/modelica/ModelicaStandardLibrary/pull/3642) (PR) Include provided header files (CI)
* [\#3643](https://github.com/modelica/ModelicaStandardLibrary/pull/3643) (PR) Fix and extend table tests (CI)
* [\#3681](https://github.com/modelica/ModelicaStandardLibrary/pull/3681) (PR) Handle redirect errors in URL checker (CI)
* [\#3709](https://github.com/modelica/ModelicaStandardLibrary/pull/3709) (PR) Utilize GitHub Actions for CI
* [\#3723](https://github.com/modelica/ModelicaStandardLibrary/pull/3723) (PR) Check Modelica files for UTF-8 BOM (CI)
* [\#3805](https://github.com/modelica/ModelicaStandardLibrary/pull/3805) (PR) Update CI to check for deprecated Text.lineColor annotation
* [\#3809](https://github.com/modelica/ModelicaStandardLibrary/pull/3809) (PR) Fix exception where tag HTML was not in lower case (CI)
* [\#3814](https://github.com/modelica/ModelicaStandardLibrary/issues/3814) Unify spelling of controllers
* [\#3851](https://github.com/modelica/ModelicaStandardLibrary/pull/3851) (PR) Update tidy-html5 (CI)
* [\#3886](https://github.com/modelica/ModelicaStandardLibrary/pull/3886) (PR) Generate MSL Release Notes by GitHub Actions (CI)
* [\#3899](https://github.com/modelica/ModelicaStandardLibrary/pull/3899) (PR) Run spelling check via GitHub Actions (CI)
* [\#3952](https://github.com/modelica/ModelicaStandardLibrary/pull/3952) (PR) Update icons almost automatically updated to have correct gradient
* [\#3972](https://github.com/modelica/ModelicaStandardLibrary/pull/3972) (PR) Add problem matchers for GitHub Actions (CI)
* [\#4072](https://github.com/modelica/ModelicaStandardLibrary/issues/4072) Near-zero coordinates in graphical annotations
* [\#4140](https://github.com/modelica/ModelicaStandardLibrary/pull/4140) (PR) Clean-up of near-zero coordinates in graphical annotations
* [\#4165](https://github.com/modelica/ModelicaStandardLibrary/pull/4165) (PR) Fix codespell exceptions (CI)
* [\#4175](https://github.com/modelica/ModelicaStandardLibrary/issues/4175) Which Modelica Language version for MSL 4.1.0?
* [\#4181](https://github.com/modelica/ModelicaStandardLibrary/pull/4181) (PR) Update text annotations to not use deprecated features
* [\#4183](https://github.com/modelica/ModelicaStandardLibrary/pull/4183) (PR) Fix regex to optionally ignore quoted strings when checking for deprecated Text.lineColor annotation (CI)
* [\#4203](https://github.com/modelica/ModelicaStandardLibrary/pull/4203) (PR) Fix codespell exceptions (CI)
* [\#4247](https://github.com/modelica/ModelicaStandardLibrary/pull/4247) (PR) Update version, uses annotation and copyright year

## Blocks

### Bugs

* [\#3627](https://github.com/modelica/ModelicaStandardLibrary/pull/3627) (PR) Blocks.Routing.Extractor: add assert for input range
* [\#3878](https://github.com/modelica/ModelicaStandardLibrary/issues/3878) Unit-checking using Gain and LimIntegrator-blocks
* [\#4045](https://github.com/modelica/ModelicaStandardLibrary/pull/4045) (PR) Fix startTime of (SignalPWM) -&gt; ZeroOrderHold 
* [\#4189](https://github.com/modelica/ModelicaStandardLibrary/pull/4189) (PR) Avoid having both start-value and initial equation

### Enhancements

* [\#3548](https://github.com/modelica/ModelicaStandardLibrary/issues/3548) Avoid unnecessary discontinuities in sources (Cosine, Sinc)?
* [\#3691](https://github.com/modelica/ModelicaStandardLibrary/pull/3691) (PR) Add reading of CSV files from ModelicaTableAdditions to ModelicaStandardTables
* [\#3692](https://github.com/modelica/ModelicaStandardLibrary/pull/3692) (PR) Add tableOnFile parameter to icon of CombiTable blocks
* [\#3762](https://github.com/modelica/ModelicaStandardLibrary/pull/3762) (PR) Add a block (based on time events) to calculate the extrema of a signal
* [\#3806](https://github.com/modelica/ModelicaStandardLibrary/pull/3806) (PR) Missing initialization of Blocks.Math.Mean and derived blocks
* [\#3831](https://github.com/modelica/ModelicaStandardLibrary/pull/3831) (PR) Implement ImpulseSources
* [\#3864](https://github.com/modelica/ModelicaStandardLibrary/issues/3864) Undesired minimum gain of LimPID
* [\#3985](https://github.com/modelica/ModelicaStandardLibrary/pull/3985) (PR) Added assert condition block
* [\#4006](https://github.com/modelica/ModelicaStandardLibrary/pull/4006) (PR) Added new power block for raising an input to a user parameterized exponent
* [\#4015](https://github.com/modelica/ModelicaStandardLibrary/pull/4015) (PR) Implement continuous version of SignalExtrema
* [\#4065](https://github.com/modelica/ModelicaStandardLibrary/issues/4065) Unnecessary potential state events in Modelica.Blocks.Sources.Pulse
* [\#4066](https://github.com/modelica/ModelicaStandardLibrary/pull/4066) (PR) Replaced state events by time events
* [\#4291](https://github.com/modelica/ModelicaStandardLibrary/pull/4291) (PR) Add the very first figure annotation

### Examples

* [\#3727](https://github.com/modelica/ModelicaStandardLibrary/issues/3727) Value of motor.uniformNoise.localSeed in ActuatorWithNoise

### Documentation

* [\#3595](https://github.com/modelica/ModelicaStandardLibrary/pull/3595) (PR) Precising the description of u1 and u2 in Division block
* [\#3683](https://github.com/modelica/ModelicaStandardLibrary/pull/3683) (PR) Document matrix name syntax for table text files
* [\#3975](https://github.com/modelica/ModelicaStandardLibrary/pull/3975) (PR) Update wrapAngle.mo

### Miscellaneous

* [\#3720](https://github.com/modelica/ModelicaStandardLibrary/pull/3720) (PR) Remove superfluous zeros from coordinates of CombiTable block icons
* [\#3881](https://github.com/modelica/ModelicaStandardLibrary/pull/3881) (PR) Revert major part of [\#227](https://github.com/modelica/ModelicaStandardLibrary/issues/227), and remove unit from gain parameter of Modelica.Blocks.Continuous.* blocks and Modelica.Blocks.Math.Gain
* [\#3893](https://github.com/modelica/ModelicaStandardLibrary/pull/3893) (PR) Consider the derivatives at boundaries in the 2D-table
* [\#3906](https://github.com/modelica/ModelicaStandardLibrary/issues/3906) Issues with Modelica.Blocks.Math.ContinuousMean
* [\#3986](https://github.com/modelica/ModelicaStandardLibrary/pull/3986) (PR) Do not preserveAspectRatio for terminate-block
* [\#4027](https://github.com/modelica/ModelicaStandardLibrary/pull/4027) (PR) Remove discrete input
* [\#4035](https://github.com/modelica/ModelicaStandardLibrary/issues/4035) startTime of (SignalPWM) -&gt; ZeroOrderHold
* [\#4055](https://github.com/modelica/ModelicaStandardLibrary/pull/4055) (PR) Propose better unit-handling in equation for LogSweep
* [\#4118](https://github.com/modelica/ModelicaStandardLibrary/pull/4118) (PR) Remove min attribute of gain in Blocks.Continuous.LimPID
* [\#4122](https://github.com/modelica/ModelicaStandardLibrary/pull/4122) (PR) Remove plural 's' in 'height of ramps'
* [\#4150](https://github.com/modelica/ModelicaStandardLibrary/pull/4150) (PR) Avoid discontinuities
* [\#4151](https://github.com/modelica/ModelicaStandardLibrary/pull/4151) (PR) Simpler mean
* [\#4180](https://github.com/modelica/ModelicaStandardLibrary/issues/4180) Remove deprecated Text.color attribute from graphical annotations
* [\#4188](https://github.com/modelica/ModelicaStandardLibrary/pull/4188) (PR) Fix unit errors in ExternalCombiTimeTable constructor
* [\#4220](https://github.com/modelica/ModelicaStandardLibrary/pull/4220) (PR) Remove real relation in non-discrete-time controlled if-statement

## C-Sources

### Bugs

* [\#3556](https://github.com/modelica/ModelicaStandardLibrary/issues/3556) MinGW possibly neglected in safe-math.h
* [\#3562](https://github.com/modelica/ModelicaStandardLibrary/issues/3562) Error message for out of bounds column in tables is broken
* [\#3563](https://github.com/modelica/ModelicaStandardLibrary/pull/3563) (PR) Fix invalid memory access in isValidCombiTimeTable and isValidCombiTable1D
* [\#3568](https://github.com/modelica/ModelicaStandardLibrary/pull/3568) (PR) Do not include intsafe.h on MinGW
* [\#3660](https://github.com/modelica/ModelicaStandardLibrary/issues/3660) Modelica.Utilities.Files.createDirectory fails if the directory does not exist
* [\#3663](https://github.com/modelica/ModelicaStandardLibrary/pull/3663) (PR) Add getcwd fallback in ModelicaInternal_fullPathName
* [\#3669](https://github.com/modelica/ModelicaStandardLibrary/pull/3669) (PR) Fix reading file with EOL=LF on Windows
* [\#3894](https://github.com/modelica/ModelicaStandardLibrary/issues/3894) Derivative signal of combiTable2Ds is set to zero outside of table with HoldLastPoint
* [\#3896](https://github.com/modelica/ModelicaStandardLibrary/pull/3896) (PR) Fix derivatives in 2D-table for one-sided extrapolation by constant continuation
* [\#3983](https://github.com/modelica/ModelicaStandardLibrary/pull/3983) (PR) Fix index-out-of-bounds exception for splines

### Enhancements

* [\#3603](https://github.com/modelica/ModelicaStandardLibrary/issues/3603) Memory allocation error in CombiTimeTable when given UTF16 LE file
* [\#3604](https://github.com/modelica/ModelicaStandardLibrary/pull/3604) (PR) ModelicaIO.c: Improve error message if reading text file containing zero bytes
* [\#3686](https://github.com/modelica/ModelicaStandardLibrary/pull/3686) (PR) Add ModelicaDuplicateString and ModelicaDuplicateStringWithErrorReturn (introduced in Modelica 3.5)
* [\#3691](https://github.com/modelica/ModelicaStandardLibrary/pull/3691) (PR) Add reading of CSV files from ModelicaTableAdditions to ModelicaStandardTables
* [\#3700](https://github.com/modelica/ModelicaStandardLibrary/pull/3700) (PR) Make array inputs of external C functions const (introduced in Modelica 3.5)
* [\#3839](https://github.com/modelica/ModelicaStandardLibrary/issues/3839) External ModelicaStandardTables lack const qualifiers for array inputs (Modelica Language Specification version 3.5)
* [\#4222](https://github.com/modelica/ModelicaStandardLibrary/pull/4222) (PR) Update matio library to 1.5.24

### Miscellaneous

* [\#3246](https://github.com/modelica/ModelicaStandardLibrary/pull/3246) (PR) Remove call of localtime
* [\#3564](https://github.com/modelica/ModelicaStandardLibrary/issues/3564) Unguarded clang pragmas in ModelicaStrings.c
* [\#3565](https://github.com/modelica/ModelicaStandardLibrary/pull/3565) (PR) Add pragma guards in ModelicaStrings.c
* [\#3647](https://github.com/modelica/ModelicaStandardLibrary/issues/3647) Linker warning mktemp is dangerous
* [\#3696](https://github.com/modelica/ModelicaStandardLibrary/pull/3696) (PR) Fix some compiler warnings
* [\#3728](https://github.com/modelica/ModelicaStandardLibrary/pull/3728) (PR) Fix Modelica.Utilities.Strings.hashString to always use provided HASH_AP and update 3rd-party header uthash to v2.3.0
* [\#3783](https://github.com/modelica/ModelicaStandardLibrary/pull/3783) (PR) Remove unused static function get_token
* [\#3784](https://github.com/modelica/ModelicaStandardLibrary/pull/3784) (PR) Fix LCC build
* [\#3787](https://github.com/modelica/ModelicaStandardLibrary/pull/3787) (PR) Fix C89 compliance
* [\#3861](https://github.com/modelica/ModelicaStandardLibrary/pull/3861) (PR) Fixed -Wundef warning by first checking if macro is defined
* [\#3867](https://github.com/modelica/ModelicaStandardLibrary/issues/3867) Is ModelicaUtilities.h tool-specific?
* [\#3871](https://github.com/modelica/ModelicaStandardLibrary/pull/3871) (PR) Remove ModelicaUtilities.h from MSL distribution
* [\#3893](https://github.com/modelica/ModelicaStandardLibrary/pull/3893) (PR) Consider the derivatives at boundaries in the 2D-table
* [\#3903](https://github.com/modelica/ModelicaStandardLibrary/issues/3903) Modelica.Blocks.Tables: Wrong format specifier is ignored
* [\#3905](https://github.com/modelica/ModelicaStandardLibrary/pull/3905) (PR) ModelicaIO.c: Fix error handling for invalid format specifier in text file
* [\#4281](https://github.com/modelica/ModelicaStandardLibrary/pull/4281) (PR) Upgrade zlib to v1.3.1

## Clocked

### Documentation

* [\#4299](https://github.com/modelica/ModelicaStandardLibrary/pull/4299) (PR) Clarify the Clocks chapter of Modelica.Clocked User Guide

### Miscellaneous

* [\#3801](https://github.com/modelica/ModelicaStandardLibrary/pull/3801) (PR) Remove duplicate "and" in doc string
* [\#3971](https://github.com/modelica/ModelicaStandardLibrary/issues/3971) Clocked noise example modifying something not in constraining class
* [\#4070](https://github.com/modelica/ModelicaStandardLibrary/issues/4070) Unused parameters in Modelica.Clocked.ClockSignals.Clocks.Logical
* [\#4071](https://github.com/modelica/ModelicaStandardLibrary/pull/4071) (PR) Propagate useSolver to these variants as well
* [\#4074](https://github.com/modelica/ModelicaStandardLibrary/pull/4074) (PR) Fix for [\#3971](https://github.com/modelica/ModelicaStandardLibrary/issues/3971)

## Complex\*

### Bugs

* [\#1260](https://github.com/modelica/ModelicaStandardLibrary/issues/1260) Complex.scalarProduct not a scalar product
* [\#3651](https://github.com/modelica/ModelicaStandardLibrary/issues/3651) Complex transfer function block uses wrong order of coefficients
* [\#3733](https://github.com/modelica/ModelicaStandardLibrary/pull/3733) (PR) Fix interpretation of coefficients of complex transfer function
* [\#3742](https://github.com/modelica/ModelicaStandardLibrary/pull/3742) (PR) Fix implementation of scalarProduct
* [\#4239](https://github.com/modelica/ModelicaStandardLibrary/pull/4239) (PR) Simplify ComplexRampPhasor

### Enhancements

* [\#3584](https://github.com/modelica/ModelicaStandardLibrary/pull/3584) (PR) Smooth complex

### Documentation

* [\#3659](https://github.com/modelica/ModelicaStandardLibrary/pull/3659) (PR) Mark ComplexBlocks and FundamentalWave with DocumentationClass

### Miscellaneous

* [\#3638](https://github.com/modelica/ModelicaStandardLibrary/pull/3638) (PR) Use one character instead of line drawings
* [\#3677](https://github.com/modelica/ModelicaStandardLibrary/pull/3677) (PR) Do not fail for w&lt;=0 in Complex TransferFunction
* [\#3768](https://github.com/modelica/ModelicaStandardLibrary/issues/3768) Conversion from ModelicaServices and Complex version 3.2.3 to 4.0.0?
* [\#3770](https://github.com/modelica/ModelicaStandardLibrary/pull/3770) (PR) Add missing conversions for Complex and Services 3.2.3
* [\#4264](https://github.com/modelica/ModelicaStandardLibrary/pull/4264) (PR) Set unit instead of having it in description

## Constants

### Bugs

* [\#2056](https://github.com/modelica/ModelicaStandardLibrary/issues/2056) Proper definition of Modelica.Constants.{eps,small}
* [\#4042](https://github.com/modelica/ModelicaStandardLibrary/pull/4042) (PR) Give a proper definition of machine constants.

### Miscellaneous

* [\#3295](https://github.com/modelica/ModelicaStandardLibrary/issues/3295) Unit of permeability
* [\#3811](https://github.com/modelica/ModelicaStandardLibrary/pull/3811) (PR) Change unit of permeability to V.s/(A.m)
* [\#4155](https://github.com/modelica/ModelicaStandardLibrary/pull/4155) (PR) Add units to mathematical constants

## Electrical.Analog

### Bugs

* [\#3827](https://github.com/modelica/ModelicaStandardLibrary/pull/3827) (PR) Fix M_Oline.segment as discussed in [\#3826](https://github.com/modelica/ModelicaStandardLibrary/issues/3826)
* [\#3828](https://github.com/modelica/ModelicaStandardLibrary/pull/3828) (PR) Fix initialization of Lines as discussed in [\#3826](https://github.com/modelica/ModelicaStandardLibrary/issues/3826)

### Enhancements

* [\#3748](https://github.com/modelica/ModelicaStandardLibrary/issues/3748) Inconsistent M_OLine
* [\#3830](https://github.com/modelica/ModelicaStandardLibrary/pull/3830) (PR) Unify Lines models
* [\#3831](https://github.com/modelica/ModelicaStandardLibrary/pull/3831) (PR) Implement ImpulseSources
* [\#3833](https://github.com/modelica/ModelicaStandardLibrary/pull/3833) (PR) Improvements to line models
* [\#3904](https://github.com/modelica/ModelicaStandardLibrary/issues/3904) DC PowerSupply missing
* [\#3926](https://github.com/modelica/ModelicaStandardLibrary/pull/3926) (PR) Implemented and tested PowerSupply

### Examples

* [\#3590](https://github.com/modelica/ModelicaStandardLibrary/pull/3590) (PR) Changed homotopy parameter to be consistent
* [\#3625](https://github.com/modelica/ModelicaStandardLibrary/pull/3625) (PR) Wrong StopTime for DifferenceAmplifier
* [\#3819](https://github.com/modelica/ModelicaStandardLibrary/pull/3819) (PR) Lines examples
* [\#4020](https://github.com/modelica/ModelicaStandardLibrary/issues/4020) This looks like a typo in the description?
* [\#4025](https://github.com/modelica/ModelicaStandardLibrary/pull/4025) (PR) [\#4020](https://github.com/modelica/ModelicaStandardLibrary/issues/4020) This looks like a typo in the description?
* [\#4206](https://github.com/modelica/ModelicaStandardLibrary/pull/4206) (PR) Remove redundant diagram text from Analog examples (second attempt)
* [\#4245](https://github.com/modelica/ModelicaStandardLibrary/issues/4245) Connect(p, p) in Modelica.Electrical.Analog.Examples.Utilities.SwitchedCapacitor?
* [\#4261](https://github.com/modelica/ModelicaStandardLibrary/pull/4261) (PR) Remove self-connect

### Documentation

* [\#3815](https://github.com/modelica/ModelicaStandardLibrary/pull/3815) (PR) Fix inconsistent M_OLine model
* [\#3960](https://github.com/modelica/ModelicaStandardLibrary/issues/3960) Documentation image M_OLine error

### Miscellaneous

* [\#3961](https://github.com/modelica/ModelicaStandardLibrary/pull/3961) (PR) Remove outdated unused image files 
* [\#3987](https://github.com/modelica/ModelicaStandardLibrary/pull/3987) (PR) Set Evaluate = true for IdealTransformer.considerMagnetization
* [\#4119](https://github.com/modelica/ModelicaStandardLibrary/pull/4119) (PR) Fix unit error in Thyristor
* [\#4147](https://github.com/modelica/ModelicaStandardLibrary/pull/4147) (PR) Fix annotations

## Electrical.Batteries

### Bugs

* [\#3878](https://github.com/modelica/ModelicaStandardLibrary/issues/3878) Unit-checking using Gain and LimIntegrator-blocks
* [\#3901](https://github.com/modelica/ModelicaStandardLibrary/issues/3901) Possible bug in Modelica.Electrical.Batteries.Utilities.PulseSeries
* [\#3902](https://github.com/modelica/ModelicaStandardLibrary/pull/3902) (PR) Electrical.Batteries.Utilities.PulseSeries

### Examples

* [\#4098](https://github.com/modelica/ModelicaStandardLibrary/issues/4098) Unit error in Modelica.Electrical.Batteries.Examples.BatteryDischargeCharge
* [\#4112](https://github.com/modelica/ModelicaStandardLibrary/pull/4112) (PR) Fix unit error in CCCVcharging

### Documentation

* [\#3804](https://github.com/modelica/ModelicaStandardLibrary/pull/3804) (PR) Fix/remove dead links

## Electrical.Digital

### Examples

* [\#4174](https://github.com/modelica/ModelicaStandardLibrary/issues/4174) Unused parameters in Modelica.Electrical.Digital.Examples.Utilities.DFF
* [\#4176](https://github.com/modelica/ModelicaStandardLibrary/pull/4176) (PR) Fix (and rename) parameters of Modelica.Electrical.Digital.Examples.Utilities.DFF

## Electrical.Machines

### Bugs

* [\#4158](https://github.com/modelica/ModelicaStandardLibrary/pull/4158) (PR) Remove unit-casting

### Enhancements

* [\#3786](https://github.com/modelica/ModelicaStandardLibrary/pull/3786) (PR) Rotational coupling
* [\#3920](https://github.com/modelica/ModelicaStandardLibrary/pull/3920) (PR) Liberate machine parameter m
* [\#4052](https://github.com/modelica/ModelicaStandardLibrary/pull/4052) (PR) Fix SI units by introducing reference phase impedance ZsRef

### Examples

* [\#3816](https://github.com/modelica/ModelicaStandardLibrary/issues/3816) Remove Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.Battery
* [\#4011](https://github.com/modelica/ModelicaStandardLibrary/pull/4011) (PR) Remove battery model from examples

### Documentation

* [\#3937](https://github.com/modelica/ModelicaStandardLibrary/issues/3937) Dead Modelica URI link in documentation
* [\#3939](https://github.com/modelica/ModelicaStandardLibrary/pull/3939) (PR) Removes commented Modelica URI link in documentation with list

### Miscellaneous

* [\#3472](https://github.com/modelica/ModelicaStandardLibrary/issues/3472) Remove reference signals of zero sequence currents of electric machine examples
* [\#3622](https://github.com/modelica/ModelicaStandardLibrary/issues/3622) Unused parameter in function
* [\#3623](https://github.com/modelica/ModelicaStandardLibrary/pull/3623) (PR) Remove unused code ([\#3622](https://github.com/modelica/ModelicaStandardLibrary/issues/3622))
* [\#3951](https://github.com/modelica/ModelicaStandardLibrary/issues/3951) Missing gradient colors in some Icons
* [\#4030](https://github.com/modelica/ModelicaStandardLibrary/issues/4030) Bug in a component: Modelica.Electrical.Machines.Sensors.HallSensor
* [\#4031](https://github.com/modelica/ModelicaStandardLibrary/pull/4031) (PR) Fix HallSensor

## Electrical.Polyphase

### Bugs

* [\#3963](https://github.com/modelica/ModelicaStandardLibrary/issues/3963) Parameter T not considered in Polyphase Resistors and Conductors
* [\#3964](https://github.com/modelica/ModelicaStandardLibrary/pull/3964) (PR) Propagate parameter T in Polyphase Resistors and Conductors

## Electrical.PowerConverters

### Bugs

* [\#3626](https://github.com/modelica/ModelicaStandardLibrary/pull/3626) (PR) Correct a bug in Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM
* [\#3897](https://github.com/modelica/ModelicaStandardLibrary/pull/3897) (PR) PowerConverters.DCDC.HBridge
* [\#3910](https://github.com/modelica/ModelicaStandardLibrary/pull/3910) (PR) Fix parameter propagation of IntersectivePWM

### Enhancements

* [\#3679](https://github.com/modelica/ModelicaStandardLibrary/pull/3679) (PR) Implement choice between sawtooth and triangle reference signal in PowerConverters/DCDC/Control/SignalPWM
* [\#3774](https://github.com/modelica/ModelicaStandardLibrary/pull/3774) (PR) Add ChopperBuckBoost to PowerConverters
* [\#3895](https://github.com/modelica/ModelicaStandardLibrary/issues/3895) Fire signals of H-Bridge

### Examples

* [\#3523](https://github.com/modelica/ModelicaStandardLibrary/issues/3523) Jumps in signal at very tiny time intervals in PolyphaseTwoLevel_RL reference results

### Documentation

* [\#3682](https://github.com/modelica/ModelicaStandardLibrary/pull/3682) (PR) Update link in documentation to no longer rely on Freescience.info
* [\#3842](https://github.com/modelica/ModelicaStandardLibrary/pull/3842) (PR) Fix permanent link redirect

### Miscellaneous

* [\#3887](https://github.com/modelica/ModelicaStandardLibrary/issues/3887) Inadequate handling of geometric corner case in PowerConverters.DCAC.Control.SVPWM
* [\#3888](https://github.com/modelica/ModelicaStandardLibrary/pull/3888) (PR) Update block descriptions of control blocks
* [\#3892](https://github.com/modelica/ModelicaStandardLibrary/pull/3892) (PR) Avoid values out of bound, and simplify logic in PowerConverters.DCAC.Control.SVPWM
* [\#4035](https://github.com/modelica/ModelicaStandardLibrary/issues/4035) startTime of (SignalPWM) -&gt; ZeroOrderHold
* [\#4054](https://github.com/modelica/ModelicaStandardLibrary/issues/4054) Model issues detected by unit checking ThreePhaseTwoLevel_PWM
* [\#4152](https://github.com/modelica/ModelicaStandardLibrary/pull/4152) (PR) Correct start-value for t0 in ThreePhaseTwoLevel

## Electrical.QuasiStatic

### Bugs

* [\#4022](https://github.com/modelica/ModelicaStandardLibrary/pull/4022) (PR) Removed duplicate definition of m 

### Enhancements

* [\#3697](https://github.com/modelica/ModelicaStandardLibrary/pull/3697) (PR) Quasi-static Transformer
* [\#3705](https://github.com/modelica/ModelicaStandardLibrary/pull/3705) (PR) Add the connection indicator to the terminal box icon
* [\#3865](https://github.com/modelica/ModelicaStandardLibrary/issues/3865) Why are there no single phase quasistatic RMS voltage and current sensors?
* [\#3876](https://github.com/modelica/ModelicaStandardLibrary/pull/3876) (PR) Add QuasiRMS voltage and current single-phase sensors

### Documentation

* [\#3873](https://github.com/modelica/ModelicaStandardLibrary/issues/3873) Documentation mentions Quasi-static AC machine models not being available
* [\#3874](https://github.com/modelica/ModelicaStandardLibrary/pull/3874) (PR) Update documentation of quasi-static AC machines
* [\#3938](https://github.com/modelica/ModelicaStandardLibrary/pull/3938) (PR) Strip leading newline in img.alt attributes

### Miscellaneous

* [\#4021](https://github.com/modelica/ModelicaStandardLibrary/issues/4021) Duplicate non-identical component in Modelica.Electrical.QuasiStatic.Polyphase.Sources.FrequencySweepVoltageSource
* [\#4264](https://github.com/modelica/ModelicaStandardLibrary/pull/4264) (PR) Set unit instead of having it in description

## Electrical.Spice3

### Documentation

* [\#3676](https://github.com/modelica/ModelicaStandardLibrary/pull/3676) (PR) Remove repeated advice on package Internal (previously called Repository)

### Miscellaneous

* [\#3576](https://github.com/modelica/ModelicaStandardLibrary/issues/3576) Rewrite if Boolean == true then
* [\#3812](https://github.com/modelica/ModelicaStandardLibrary/pull/3812) (PR) Simplify "if Boolean == true" to "if Boolean"
* [\#4135](https://github.com/modelica/ModelicaStandardLibrary/pull/4135) (PR) Delete redundant points of polygon annotation of connectors

## Fluid

### Bugs

* [\#3758](https://github.com/modelica/ModelicaStandardLibrary/issues/3758) Jump in Modelica.Fluid.Pipes.BaseClasses.WallFriction.LaminarAndQuadraticTurbulent.massFlowRate_dp_staticHead
* [\#3924](https://github.com/modelica/ModelicaStandardLibrary/pull/3924) (PR) Fix the bad Evaluate annotation
* [\#3944](https://github.com/modelica/ModelicaStandardLibrary/issues/3944) Bug in the SharpEdgedOrifice for Loss factors
* [\#3953](https://github.com/modelica/ModelicaStandardLibrary/issues/3953) Wrong enthalpies calculated by DynamicPipe
* [\#3959](https://github.com/modelica/ModelicaStandardLibrary/pull/3959) (PR) Fixed Wb_flows discretization terms for DynamicPipe
* [\#4144](https://github.com/modelica/ModelicaStandardLibrary/issues/4144) Dimension mismatch in function linearPower
* [\#4258](https://github.com/modelica/ModelicaStandardLibrary/pull/4258) (PR) Bug in SharpEdgedOrifice for Loss factors resolved
* [\#4259](https://github.com/modelica/ModelicaStandardLibrary/pull/4259) (PR) Fix dimension error of Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearPower

### Examples

* [\#3654](https://github.com/modelica/ModelicaStandardLibrary/pull/3654) (PR) Remove unused/undocumented block setReal from example
* [\#3656](https://github.com/modelica/ModelicaStandardLibrary/issues/3656) The reference solution of Modelica.Fluid.Examples.Explanatory.MomentumBalanceFittings is wrong
* [\#3657](https://github.com/modelica/ModelicaStandardLibrary/pull/3657) (PR) Add start value to ensure convergence to the right flow in suddenExpansion1
* [\#3779](https://github.com/modelica/ModelicaStandardLibrary/pull/3779) (PR) choicesAllMatching=true is the correct annotation!
* [\#3782](https://github.com/modelica/ModelicaStandardLibrary/issues/3782) What is the quality of the TankWithEmptyingPipe1 reference result?
* [\#3813](https://github.com/modelica/ModelicaStandardLibrary/pull/3813) (PR) Decrease solver tolerance of Modelica.Fluid.Examples.AST_BatchPlant.Test.TankWithEmptyingPipe1
* [\#4032](https://github.com/modelica/ModelicaStandardLibrary/pull/4032) (PR) The dT is a temperature difference
* [\#4033](https://github.com/modelica/ModelicaStandardLibrary/pull/4033) (PR) Reduce guess for initial temperature difference across wall.

### Documentation

* [\#3629](https://github.com/modelica/ModelicaStandardLibrary/pull/3629) (PR) Fix outdated contact
* [\#3715](https://github.com/modelica/ModelicaStandardLibrary/pull/3715) (PR) Remove superfluous blank line in documentation of Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction
* [\#3863](https://github.com/modelica/ModelicaStandardLibrary/pull/3863) (PR) Add missing parenthesis in fluid user guide page

### Miscellaneous

* [\#3649](https://github.com/modelica/ModelicaStandardLibrary/pull/3649) (PR) Just use "redeclare" instead of "redeclare final"
* [\#3760](https://github.com/modelica/ModelicaStandardLibrary/pull/3760) (PR) Fix assert message of Modelica.Fluid.Pipes.BaseClasses.WallFriction.NoFriction.massFlowRate_dp_staticHead
* [\#3802](https://github.com/modelica/ModelicaStandardLibrary/pull/3802) (PR) State temperatures in PartialHeatTransfer declared as Medium-specific type
* [\#3951](https://github.com/modelica/ModelicaStandardLibrary/issues/3951) Missing gradient colors in some Icons
* [\#4104](https://github.com/modelica/ModelicaStandardLibrary/pull/4104) (PR) Remove modification of 'quantity' for FixedBoundary.X
* [\#4157](https://github.com/modelica/ModelicaStandardLibrary/pull/4157) (PR) If the limits don't make sense use linear interpolation in Modelica.Fluid.Utilities.regfun3

## Fluid.Dissipation

### Enhancements

* [\#1429](https://github.com/modelica/ModelicaStandardLibrary/issues/1429) Conditionally uninitialized output variable Re in Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube used

### Miscellaneous

* [\#3743](https://github.com/modelica/ModelicaStandardLibrary/pull/3743) (PR) Resort variable declarations of Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.{kc_flatTube, kc_flatTube_KC, kc_roundTube_KC} such that they are declared before used
* [\#3744](https://github.com/modelica/ModelicaStandardLibrary/pull/3744) (PR) Add assertion in else branches of Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.{kc_flatTube, kc_flatTube_KC, kc_roundTube, kc_roundTube_KC}
* [\#4147](https://github.com/modelica/ModelicaStandardLibrary/pull/4147) (PR) Fix annotations

## Icons

### Miscellaneous

* [\#3632](https://github.com/modelica/ModelicaStandardLibrary/pull/3632) (PR) Render borders
* [\#4135](https://github.com/modelica/ModelicaStandardLibrary/pull/4135) (PR) Delete redundant points of polygon annotation of connectors

## Magnetic.FluxTubes

### Bugs

* [\#4158](https://github.com/modelica/ModelicaStandardLibrary/pull/4158) (PR) Remove unit-casting

### Enhancements

* [\#3993](https://github.com/modelica/ModelicaStandardLibrary/pull/3993) (PR) FluxTubes: some improvements in shapes and material

### Examples

* [\#4077](https://github.com/modelica/ModelicaStandardLibrary/issues/4077) Unit error in Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.ArmatureStroke
* [\#4109](https://github.com/modelica/ModelicaStandardLibrary/pull/4109) (PR) Fix unit errors in ArmatureStroke

### Documentation

* [\#3847](https://github.com/modelica/ModelicaStandardLibrary/pull/3847) (PR) Fix link
* [\#4211](https://github.com/modelica/ModelicaStandardLibrary/pull/4211) (PR) Fix broken link in Modelica.Magnetic.FluxTubes

### Miscellaneous

* [\#3295](https://github.com/modelica/ModelicaStandardLibrary/issues/3295) Unit of permeability
* [\#3951](https://github.com/modelica/ModelicaStandardLibrary/issues/3951) Missing gradient colors in some Icons
* [\#4007](https://github.com/modelica/ModelicaStandardLibrary/issues/4007) Redundant connect equation in ConstantActuator
* [\#4008](https://github.com/modelica/ModelicaStandardLibrary/pull/4008) (PR) Remove redundant connect equation in ConstantActuator

## Magnetic.FundamentalWave

### Bugs

* [\#4158](https://github.com/modelica/ModelicaStandardLibrary/pull/4158) (PR) Remove unit-casting
* [\#4172](https://github.com/modelica/ModelicaStandardLibrary/pull/4172) (PR) Protect internal ports of base class machines

### Enhancements

* [\#3817](https://github.com/modelica/ModelicaStandardLibrary/pull/3817) (PR) Implemented split of stray inductance in common and individual part

### Examples

* [\#3822](https://github.com/modelica/ModelicaStandardLibrary/pull/3822) (PR) Add documentation of SinglePhaseInductance

### Documentation

* [\#3736](https://github.com/modelica/ModelicaStandardLibrary/pull/3736) (PR) More clearly specify damper cage in synchronous machine models

### Miscellaneous

* [\#3472](https://github.com/modelica/ModelicaStandardLibrary/issues/3472) Remove reference signals of zero sequence currents of electric machine examples
* [\#4187](https://github.com/modelica/ModelicaStandardLibrary/pull/4187) (PR) Remove newlines at end of Text primitive

## Magnetic.QuasiStatic

### Bugs

* [\#3997](https://github.com/modelica/ModelicaStandardLibrary/pull/3997) (PR) Propagate the angle alpha also in the calculation of A in HollowCylinderRadialFlux
* [\#4158](https://github.com/modelica/ModelicaStandardLibrary/pull/4158) (PR) Remove unit-casting
* [\#4172](https://github.com/modelica/ModelicaStandardLibrary/pull/4172) (PR) Protect internal ports of base class machines

### Enhancements

* [\#3993](https://github.com/modelica/ModelicaStandardLibrary/pull/3993) (PR) FluxTubes: some improvements in shapes and material

### Examples

* [\#3592](https://github.com/modelica/ModelicaStandardLibrary/pull/3592) (PR) Fix name of plot variable in documentation
* [\#3803](https://github.com/modelica/ModelicaStandardLibrary/pull/3803) (PR) Added an example to demonstrate ideal field weakening 
* [\#3845](https://github.com/modelica/ModelicaStandardLibrary/pull/3845) (PR) QuasiStatic example induction machine with inverter

### Documentation

* [\#3593](https://github.com/modelica/ModelicaStandardLibrary/issues/3593) Check documentation of induction machines' examples
* [\#3659](https://github.com/modelica/ModelicaStandardLibrary/pull/3659) (PR) Mark ComplexBlocks and FundamentalWave with DocumentationClass
* [\#3736](https://github.com/modelica/ModelicaStandardLibrary/pull/3736) (PR) More clearly specify damper cage in synchronous machine models
* [\#3823](https://github.com/modelica/ModelicaStandardLibrary/pull/3823) (PR) Remove obsolete "(quasi-static)" from documentation

### Miscellaneous

* [\#3472](https://github.com/modelica/ModelicaStandardLibrary/issues/3472) Remove reference signals of zero sequence currents of electric machine examples
* [\#3620](https://github.com/modelica/ModelicaStandardLibrary/pull/3620) (PR) Refs [\#3593](https://github.com/modelica/ModelicaStandardLibrary/issues/3593): Fix documentation of quasi-static machine examples

## Math

### Bugs

* [\#3836](https://github.com/modelica/ModelicaStandardLibrary/issues/3836) Incorrect results from isPowerOf2 for large inputs
* [\#3850](https://github.com/modelica/ModelicaStandardLibrary/pull/3850) (PR) Avoid max({}) in Modelica.Math.Matrices.nullSpace

### Enhancements

* [\#3919](https://github.com/modelica/ModelicaStandardLibrary/pull/3919) (PR) Use boolean array reductions

### Miscellaneous

* [\#3578](https://github.com/modelica/ModelicaStandardLibrary/issues/3578) Order Modelica.Math.Matrices.LAPACK
* [\#3602](https://github.com/modelica/ModelicaStandardLibrary/pull/3602) (PR) Reorder Lapack functions in alphabetic order
* [\#3703](https://github.com/modelica/ModelicaStandardLibrary/pull/3703) (PR) Avoid deprecated "builtin" external language for common mathematical functions
* [\#3843](https://github.com/modelica/ModelicaStandardLibrary/pull/3843) (PR) Fully integer based version of isPowerOf2
* [\#3849](https://github.com/modelica/ModelicaStandardLibrary/issues/3849) Invalid function Modelica.Math.Matrices.nullSpace calculating max({})
* [\#4036](https://github.com/modelica/ModelicaStandardLibrary/issues/4036) Illegal value of 'lwork' in LAPACK.dtrsen
* [\#4039](https://github.com/modelica/ModelicaStandardLibrary/pull/4039) (PR) Most LAPACK routines don't want lwork=0 and/or work with size zero
* [\#4314](https://github.com/modelica/ModelicaStandardLibrary/pull/4314) (PR) Compatibility fix for Dymola 2024x; not needed in coming release.

## Mechanics.MultiBody

### Bugs

* [\#3588](https://github.com/modelica/ModelicaStandardLibrary/issues/3588) Quaternions.from_T returns error for valid matrix
* [\#3710](https://github.com/modelica/ModelicaStandardLibrary/issues/3710) Singular Jacobian of the initial equations for the rotational constraint in Modelica.Mechanics.MultiBody.Joints.Constraints.Prismatic
* [\#3718](https://github.com/modelica/ModelicaStandardLibrary/pull/3718) (PR) Correct Constraints.Prismatic
* [\#3989](https://github.com/modelica/ModelicaStandardLibrary/issues/3989) ForceAndTorque model does not set color of force arrow
* [\#3990](https://github.com/modelica/ModelicaStandardLibrary/pull/3990) (PR) Pass forceColor to arrow visualizer
* [\#4145](https://github.com/modelica/ModelicaStandardLibrary/issues/4145) Error with frame_resolve math in BasicAbsoluteAngularVelocity sensor
* [\#4148](https://github.com/modelica/ModelicaStandardLibrary/pull/4148) (PR) Fix false calculation of w (omega) when resolveInFrame == frame_resolve

### Enhancements

* [\#3724](https://github.com/modelica/ModelicaStandardLibrary/pull/3724) (PR) Stable calculation of quaternion from transformation matrix
* [\#3859](https://github.com/modelica/ModelicaStandardLibrary/pull/3859) (PR) Fix missing or ambiguous SI-units in MultiBody.Sensors
* [\#3908](https://github.com/modelica/ModelicaStandardLibrary/issues/3908) Late inlining of Modelica.Mechanics.MultiBody.Frames.Internal.maxWithoutEvent
* [\#4133](https://github.com/modelica/ModelicaStandardLibrary/pull/4133) (PR) Replace 'Inline=false' with late inlining

### Examples

* [\#3706](https://github.com/modelica/ModelicaStandardLibrary/issues/3706) Wrongly fixed initial conditions in example Modelica.Mechanics.MultiBody.Examples.Constraints.PrismaticConstraint
* [\#3712](https://github.com/modelica/ModelicaStandardLibrary/pull/3712) (PR) Initialize motion in x direction (r_rel_a_1) instead of in z (r_rel_a_3)
* [\#3776](https://github.com/modelica/ModelicaStandardLibrary/issues/3776) Link rot
* [\#3866](https://github.com/modelica/ModelicaStandardLibrary/issues/3866) startBackward and startForward should not be reference results
* [\#3870](https://github.com/modelica/ModelicaStandardLibrary/pull/3870) (PR) Remove startBackward and startForward from reference results
* [\#4080](https://github.com/modelica/ModelicaStandardLibrary/issues/4080) Unit error in Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.GasForce2
* [\#4081](https://github.com/modelica/ModelicaStandardLibrary/pull/4081) (PR) Delete variables dens and R_air from Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.GasForce2
* [\#4108](https://github.com/modelica/ModelicaStandardLibrary/pull/4108) (PR) Fix unit error in RobotR3.OneAxis

### Documentation

* [\#3610](https://github.com/modelica/ModelicaStandardLibrary/issues/3610) shapeType documentation example for file:// is inconsistent with standard file URIs
* [\#3613](https://github.com/modelica/ModelicaStandardLibrary/pull/3613) (PR) Add missing URI separator in file URIs
* [\#3804](https://github.com/modelica/ModelicaStandardLibrary/pull/3804) (PR) Fix/remove dead links
* [\#3933](https://github.com/modelica/ModelicaStandardLibrary/pull/3933) (PR) Update documentation of Modelica.Mechanics.MultiBody.Visualizers.Advanced
* [\#4184](https://github.com/modelica/ModelicaStandardLibrary/pull/4184) (PR) Restore documentation of Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines
* [\#4217](https://github.com/modelica/ModelicaStandardLibrary/pull/4217) (PR) Documentation: clarify mind-set of planar rotation

### Miscellaneous

* [\#2474](https://github.com/modelica/ModelicaStandardLibrary/issues/2474) Spherical, etc. render poorly on non-white backgrounds
* [\#3445](https://github.com/modelica/ModelicaStandardLibrary/issues/3445) Wrong rotation direction in planarRotation functions
* [\#3634](https://github.com/modelica/ModelicaStandardLibrary/pull/3634) (PR) Utilize ellipses' closure
* [\#3716](https://github.com/modelica/ModelicaStandardLibrary/pull/3716) (PR) Improve icons of joint assemblies RRR and RRP
* [\#3725](https://github.com/modelica/ModelicaStandardLibrary/pull/3725) (PR) Simplify selection of constraint equations to be used
* [\#3729](https://github.com/modelica/ModelicaStandardLibrary/pull/3729) (PR) Fix position of component's and parameter's name according to icon conventions
* [\#3730](https://github.com/modelica/ModelicaStandardLibrary/pull/3730) (PR) Use ellipses instead of arcs by lines in Mechanics.MultiBody.Forces
* [\#3835](https://github.com/modelica/ModelicaStandardLibrary/pull/3835) (PR) Remove Evaluate=true for fixed=false parameter 'n_b'
* [\#3932](https://github.com/modelica/ModelicaStandardLibrary/pull/3932) (PR) Remove superfluous import statements for Modelica.Units.Conversions.to_unit1
* [\#4147](https://github.com/modelica/ModelicaStandardLibrary/pull/4147) (PR) Fix annotations
* [\#4171](https://github.com/modelica/ModelicaStandardLibrary/pull/4171) (PR) Initialize output array C even when multiColoredSurface=false
* [\#4192](https://github.com/modelica/ModelicaStandardLibrary/issues/4192) Unit errors when calling Modelica.Mechanics.MultiBody.Frames.from_nxy
* [\#4194](https://github.com/modelica/ModelicaStandardLibrary/pull/4194) (PR) Correct units for normalizing vectors.
* [\#4246](https://github.com/modelica/ModelicaStandardLibrary/issues/4246) Unused ndim in MBS World
* [\#4248](https://github.com/modelica/ModelicaStandardLibrary/pull/4248) (PR) Use vector for visualization of physical quantities
* [\#4266](https://github.com/modelica/ModelicaStandardLibrary/pull/4266) (PR) Delete unused protected parameters ndim, ndim2 and ndim_pointGravity

## Mechanics.Rotational

### Enhancements

* [\#3661](https://github.com/modelica/ModelicaStandardLibrary/issues/3661) Improve table design of Modelica.Mechanics.Rotational.Components.Clutch to use static tables instead of dynamic
* [\#3662](https://github.com/modelica/ModelicaStandardLibrary/pull/3662) (PR) Enhance frictional models based on ExternalCombiTable1D
* [\#3702](https://github.com/modelica/ModelicaStandardLibrary/pull/3702) (PR) Rotational and translational inverse speed dependent torque/force
* [\#3786](https://github.com/modelica/ModelicaStandardLibrary/pull/3786) (PR) Rotational coupling
* [\#3976](https://github.com/modelica/ModelicaStandardLibrary/pull/3976) (PR) Eddy current sources

### Examples

* [\#3866](https://github.com/modelica/ModelicaStandardLibrary/issues/3866) startBackward and startForward should not be reference results
* [\#3870](https://github.com/modelica/ModelicaStandardLibrary/pull/3870) (PR) Remove startBackward and startForward from reference results
* [\#4010](https://github.com/modelica/ModelicaStandardLibrary/pull/4010) (PR) Minor fixes of the documentation of Mechanics.Rotational.Examples

### Documentation

* [\#1493](https://github.com/modelica/ModelicaStandardLibrary/issues/1493) Mechanics.Rotational.Interfaces.PartialFriction.w_small
* [\#3594](https://github.com/modelica/ModelicaStandardLibrary/pull/3594) (PR) Fix wrong or missing documentation
* [\#3633](https://github.com/modelica/ModelicaStandardLibrary/pull/3633) (PR) Describe the effect of w_small in friction elements 
* [\#3862](https://github.com/modelica/ModelicaStandardLibrary/pull/3862) (PR) Improve documentation of both rotational and translational sensors

### Miscellaneous

* [\#3735](https://github.com/modelica/ModelicaStandardLibrary/pull/3735) (PR) Use ellipses instead of arcs by lines
* [\#4204](https://github.com/modelica/ModelicaStandardLibrary/pull/4204) (PR) Use mustBeConnected annotation (introduced in Modelica 3.6) 
* [\#4256](https://github.com/modelica/ModelicaStandardLibrary/pull/4256) (PR) Fix position prescribed friction

## Mechanics.Translational

### Enhancements

* [\#3664](https://github.com/modelica/ModelicaStandardLibrary/issues/3664) Improve design of frictional translational components to use static tables instead of dynamic
* [\#3690](https://github.com/modelica/ModelicaStandardLibrary/pull/3690) (PR) Enhance frictional translational models based on ExternalCombiTable1D
* [\#3702](https://github.com/modelica/ModelicaStandardLibrary/pull/3702) (PR) Rotational and translational inverse speed dependent torque/force
* [\#3976](https://github.com/modelica/ModelicaStandardLibrary/pull/3976) (PR) Eddy current sources

### Examples

* [\#3866](https://github.com/modelica/ModelicaStandardLibrary/issues/3866) startBackward and startForward should not be reference results
* [\#3870](https://github.com/modelica/ModelicaStandardLibrary/pull/3870) (PR) Remove startBackward and startForward from reference results

### Documentation

* [\#3594](https://github.com/modelica/ModelicaStandardLibrary/pull/3594) (PR) Fix wrong or missing documentation
* [\#3862](https://github.com/modelica/ModelicaStandardLibrary/pull/3862) (PR) Improve documentation of both rotational and translational sensors
* [\#3942](https://github.com/modelica/ModelicaStandardLibrary/pull/3942) (PR) Fix copy/paste error in description of Translational.Sources.Force2

### Miscellaneous

* [\#4197](https://github.com/modelica/ModelicaStandardLibrary/issues/4197) Unit issue in Modelica.Mechanics.Translational.Components.ElastoGap
* [\#4200](https://github.com/modelica/ModelicaStandardLibrary/pull/4200) (PR) Improve ElastoGap
* [\#4204](https://github.com/modelica/ModelicaStandardLibrary/pull/4204) (PR) Use mustBeConnected annotation (introduced in Modelica 3.6) 
* [\#4256](https://github.com/modelica/ModelicaStandardLibrary/pull/4256) (PR) Fix position prescribed friction

## Media

### Bugs

* [\#3666](https://github.com/modelica/ModelicaStandardLibrary/issues/3666) ReferenceMoistAir, substances mass conservation issue
* [\#3695](https://github.com/modelica/ModelicaStandardLibrary/issues/3695) Trajectory of 'k' in R134a_setState_pTX doesn't look suitable for comparison
* [\#3704](https://github.com/modelica/ModelicaStandardLibrary/pull/3704) (PR) Changed Modelica.Media.R134a.R134a_ph.dofpT issue [\#3695](https://github.com/modelica/ModelicaStandardLibrary/issues/3695)
* [\#3834](https://github.com/modelica/ModelicaStandardLibrary/pull/3834) (PR) Correct error in function Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX_der

### Examples

* [\#4099](https://github.com/modelica/ModelicaStandardLibrary/issues/4099) Unit error in Modelica.Media.Examples.SimpleLiquidWater
* [\#4115](https://github.com/modelica/ModelicaStandardLibrary/pull/4115) (PR) Fix unit errors in Examples.MoistAir

### Documentation

* [\#3629](https://github.com/modelica/ModelicaStandardLibrary/pull/3629) (PR) Fix outdated contact
* [\#4084](https://github.com/modelica/ModelicaStandardLibrary/pull/4084) (PR) Documentation: improve indentation of HTML code

### Miscellaneous

* [\#3576](https://github.com/modelica/ModelicaStandardLibrary/issues/3576) Rewrite if Boolean == true then
* [\#3650](https://github.com/modelica/ModelicaStandardLibrary/issues/3650) Modelica Media Interface is information incomplete w.r.t. independent mass fractions
* [\#3652](https://github.com/modelica/ModelicaStandardLibrary/pull/3652) (PR) Fix descriptions and improve documentation style
* [\#3763](https://github.com/modelica/ModelicaStandardLibrary/pull/3763) (PR) Make constants in functions protected
* [\#3766](https://github.com/modelica/ModelicaStandardLibrary/pull/3766) (PR) Update FluidData.mo
* [\#3812](https://github.com/modelica/ModelicaStandardLibrary/pull/3812) (PR) Simplify "if Boolean == true" to "if Boolean"
* [\#3885](https://github.com/modelica/ModelicaStandardLibrary/pull/3885) (PR) Refactor spliceFunction_der
* [\#4038](https://github.com/modelica/ModelicaStandardLibrary/pull/4038) (PR) spliceFunction_der check limits
* [\#4096](https://github.com/modelica/ModelicaStandardLibrary/pull/4096) (PR) Fix unit error in SimpleAir
* [\#4100](https://github.com/modelica/ModelicaStandardLibrary/pull/4100) (PR) Use plain SI.Mass instead of medium-based 'quantity' for MixtureGases.m1 and MixtureGases.m2
* [\#4103](https://github.com/modelica/ModelicaStandardLibrary/pull/4103) (PR) Fix unit error in SimpleLiquidWater model
* [\#4116](https://github.com/modelica/ModelicaStandardLibrary/pull/4116) (PR) Fix unit errors in ReferenceAir.MoistAir
* [\#4117](https://github.com/modelica/ModelicaStandardLibrary/pull/4117) (PR) Fix unit error in IdealGasH2O
* [\#4233](https://github.com/modelica/ModelicaStandardLibrary/issues/4233) Old value for universal gas constant used for calculation of specific gas constant
* [\#4238](https://github.com/modelica/ModelicaStandardLibrary/pull/4238) (PR) R_s for each ideal gas record now calculated with R_NASA
* [\#4243](https://github.com/modelica/ModelicaStandardLibrary/pull/4243) (PR) Add massFraction function to Media library 
* [\#4262](https://github.com/modelica/ModelicaStandardLibrary/pull/4262) (PR) Utilize PressureSlope unit in Media consistently

## ModelicaReference

### Documentation

* [\#3773](https://github.com/modelica/ModelicaStandardLibrary/issues/3773) getInstanceName and spatialDistribution not listed in ModelicaReference
* [\#3808](https://github.com/modelica/ModelicaStandardLibrary/pull/3808) (PR) getInstanceName and spatialDistribution not listed in ModelicaReference
* [\#3980](https://github.com/modelica/ModelicaStandardLibrary/pull/3980) (PR) Fix variable name
* [\#4023](https://github.com/modelica/ModelicaStandardLibrary/issues/4023) Obsolete form of noDerivative in ModelicaReference
* [\#4024](https://github.com/modelica/ModelicaStandardLibrary/pull/4024) (PR) Update obsolete form of noDerivative in ModelicaReference
* [\#4127](https://github.com/modelica/ModelicaStandardLibrary/pull/4127) (PR) Type cast result of malloc
* [\#4298](https://github.com/modelica/ModelicaStandardLibrary/pull/4298) (PR) Fix syntax errors in ModelicaReference documentation snippets

### Miscellaneous

* [\#3923](https://github.com/modelica/ModelicaStandardLibrary/pull/3923) (PR) Fix misspelled file name

## ModelicaServices

### Miscellaneous

* [\#3768](https://github.com/modelica/ModelicaStandardLibrary/issues/3768) Conversion from ModelicaServices and Complex version 3.2.3 to 4.0.0?
* [\#3770](https://github.com/modelica/ModelicaStandardLibrary/pull/3770) (PR) Add missing conversions for Complex and Services 3.2.3

## ModelicaTest

### Bugs

* [\#3695](https://github.com/modelica/ModelicaStandardLibrary/issues/3695) Trajectory of 'k' in R134a_setState_pTX doesn't look suitable for comparison

### Enhancements

* [\#3689](https://github.com/modelica/ModelicaStandardLibrary/pull/3689) (PR) Add 2 more test examples to ModelicaTest.Electrical.Machines

### Examples

* [\#3866](https://github.com/modelica/ModelicaStandardLibrary/issues/3866) startBackward and startForward should not be reference results
* [\#3870](https://github.com/modelica/ModelicaStandardLibrary/pull/3870) (PR) Remove startBackward and startForward from reference results

### Miscellaneous

* [\#3778](https://github.com/modelica/ModelicaStandardLibrary/issues/3778) Reference result degradation for TestValvesCompressibleReverse (fixed by Dymola 2022)
* [\#3852](https://github.com/modelica/ModelicaStandardLibrary/issues/3852) Invalid models ModelicaTest.Media.TestsWithFluids.MediaTestModels.*
* [\#3881](https://github.com/modelica/ModelicaStandardLibrary/pull/3881) (PR) Revert major part of [\#227](https://github.com/modelica/ModelicaStandardLibrary/issues/227), and remove unit from gain parameter of Modelica.Blocks.Continuous.* blocks and Modelica.Blocks.Math.Gain
* [\#3918](https://github.com/modelica/ModelicaStandardLibrary/pull/3918) (PR) Update ModelicaTest/Media.mo: Reduce dp_nominal in TestsWithFluid.Components.PartialTestModel by a factor of 1000
* [\#4114](https://github.com/modelica/ModelicaStandardLibrary/pull/4114) (PR) Fix unit error in TestOnly.MoistAir, R134a_setState_pTX and WaterIF97_dewEnthalpy
* [\#4195](https://github.com/modelica/ModelicaStandardLibrary/pull/4195) (PR) Add all defined outputs of the test example to reference signals
* [\#4229](https://github.com/modelica/ModelicaStandardLibrary/pull/4229) (PR) Add ZeroThresholds test in Blocks
* [\#4273](https://github.com/modelica/ModelicaStandardLibrary/pull/4273) (PR) Utilize PressureSlope unit in ModelicaTest consistently

## Resources

### Bugs

* [\#3614](https://github.com/modelica/ModelicaStandardLibrary/pull/3614) (PR) Update Run.mos for MultiBody examples
* [\#3767](https://github.com/modelica/ModelicaStandardLibrary/pull/3767) (PR) Add more explicit conversion rules for inherited gasConstant function

### Documentation

* [\#4251](https://github.com/modelica/ModelicaStandardLibrary/pull/4251) (PR) Create Modelica.UsersGuide.ReleaseNotes.Version_4_1_0

### Miscellaneous

* [\#3580](https://github.com/modelica/ModelicaStandardLibrary/pull/3580) (PR) Save the CFLAGS already passed to the script
* [\#3591](https://github.com/modelica/ModelicaStandardLibrary/pull/3591) (PR) Remove zero inductor currents in comparison signals
* [\#3618](https://github.com/modelica/ModelicaStandardLibrary/pull/3618) (PR) Fix result file name in Run.mos script
* [\#3753](https://github.com/modelica/ModelicaStandardLibrary/pull/3753) (PR) Add semicolon after conversion commands of ConvertModelica_from_3.2.3_to_4.0.0.mos
* [\#3794](https://github.com/modelica/ModelicaStandardLibrary/pull/3794) (PR) Turn compiler warning of implicit function declaration to error
* [\#3800](https://github.com/modelica/ModelicaStandardLibrary/pull/3800) (PR) Fix (all but one) conversion issues reported by Dymola
* [\#3867](https://github.com/modelica/ModelicaStandardLibrary/issues/3867) Is ModelicaUtilities.h tool-specific?
* [\#3871](https://github.com/modelica/ModelicaStandardLibrary/pull/3871) (PR) Remove ModelicaUtilities.h from MSL distribution
* [\#3961](https://github.com/modelica/ModelicaStandardLibrary/pull/3961) (PR) Remove outdated unused image files 
* [\#4167](https://github.com/modelica/ModelicaStandardLibrary/pull/4167) (PR) Remove voltageSensor.v from the comparison list
* [\#4179](https://github.com/modelica/ModelicaStandardLibrary/pull/4179) (PR) Remove duplicates in SignalNames of 10 examples of ModelicaTest
* [\#4268](https://github.com/modelica/ModelicaStandardLibrary/pull/4268) (PR) Make third-party licenses explicit
* [\#4316](https://github.com/modelica/ModelicaStandardLibrary/issues/4316) MSL v4.1.0-beta.1 feedback: broken Dymola plot scripts
* [\#4322](https://github.com/modelica/ModelicaStandardLibrary/pull/4322) (PR) Fix plot scripts

## StateGraph

### Examples

* [\#4076](https://github.com/modelica/ModelicaStandardLibrary/issues/4076) Modelica.StateGraph.Examples.Utilities.Tank could set units for its variables.

### Documentation

* [\#4202](https://github.com/modelica/ModelicaStandardLibrary/pull/4202) (PR) Fix broken links in Modelica.StateGraph

### Miscellaneous

* [\#4264](https://github.com/modelica/ModelicaStandardLibrary/pull/4264) (PR) Set unit instead of having it in description

## Thermal.FluidHeatFlow

### Enhancements

* [\#3956](https://github.com/modelica/ModelicaStandardLibrary/pull/3956) (PR) Add animated level on the icon layer of the OpenTank

### Examples

* [\#4141](https://github.com/modelica/ModelicaStandardLibrary/pull/4141) (PR) Documentation and description for FluidHeatFlow library improved

### Documentation

* [\#3474](https://github.com/modelica/ModelicaStandardLibrary/issues/3474) Improve doc strings and documentation of FluidHeatFlow

## Thermal.HeatTransfer

### Documentation

* [\#3954](https://github.com/modelica/ModelicaStandardLibrary/issues/3954) Broken link to academia.edu
* [\#4199](https://github.com/modelica/ModelicaStandardLibrary/pull/4199) (PR) Fix link to Holman2010

## Units

### Enhancements

* [\#3872](https://github.com/modelica/ModelicaStandardLibrary/pull/3872) (PR) Add electrical quantities per unit length

### Miscellaneous

* [\#3295](https://github.com/modelica/ModelicaStandardLibrary/issues/3295) Unit of permeability
* [\#3811](https://github.com/modelica/ModelicaStandardLibrary/pull/3811) (PR) Change unit of permeability to V.s/(A.m)
* [\#4103](https://github.com/modelica/ModelicaStandardLibrary/pull/4103) (PR) Fix unit error in SimpleLiquidWater model
* [\#4105](https://github.com/modelica/ModelicaStandardLibrary/pull/4105) (PR) Add StoichiometricCoefficient next to StoichiometricNumber
* [\#4264](https://github.com/modelica/ModelicaStandardLibrary/pull/4264) (PR) Set unit instead of having it in description

## UsersGuide

### Documentation

* [\#3804](https://github.com/modelica/ModelicaStandardLibrary/pull/3804) (PR) Fix/remove dead links
* [\#3844](https://github.com/modelica/ModelicaStandardLibrary/issues/3844) Conflicting guidelines for HTML documentation conventions for tables
* [\#3848](https://github.com/modelica/ModelicaStandardLibrary/pull/3848) (PR) Remove `align=bottom` from guidelines and code
* [\#3854](https://github.com/modelica/ModelicaStandardLibrary/pull/3854) (PR) Remove obsoleted BMBF link
* [\#4216](https://github.com/modelica/ModelicaStandardLibrary/pull/4216) (PR) Add recommendation for styling of 'tab' and 'group' annotations
* [\#4221](https://github.com/modelica/ModelicaStandardLibrary/pull/4221) (PR) Add recommendation for code formatting (and apply it)
* [\#4251](https://github.com/modelica/ModelicaStandardLibrary/pull/4251) (PR) Create Modelica.UsersGuide.ReleaseNotes.Version_4_1_0

## Utilities

### Bugs

* [\#3615](https://github.com/modelica/ModelicaStandardLibrary/issues/3615) ModelicaServices classes extends from classes in a partial package
* [\#3617](https://github.com/modelica/ModelicaStandardLibrary/pull/3617) (PR) Models should be partial, not the package

### Enhancements

* [\#3503](https://github.com/modelica/ModelicaStandardLibrary/pull/3503) (PR) Improve fault-tolerance of Modelica.Utilities.Strings.substring w.r.t. index arguments and remove undocumented case with endIndex=-999

### Examples

* [\#3608](https://github.com/modelica/ModelicaStandardLibrary/issues/3608) Incorrect dimension parameter used when defining A in Modelica.Utilities.Examples.ReadRealMatrixFromFile 
* [\#3609](https://github.com/modelica/ModelicaStandardLibrary/pull/3609) (PR) Use correct dimensions
* [\#3921](https://github.com/modelica/ModelicaStandardLibrary/issues/3921) Enhancement of Modelica.Utilities.Examples.readRealParameter
* [\#3922](https://github.com/modelica/ModelicaStandardLibrary/pull/3922) (PR) Adds optional default return value parameter

### Documentation

* [\#4059](https://github.com/modelica/ModelicaStandardLibrary/pull/4059) (PR) Document unicode for String functions
* [\#4073](https://github.com/modelica/ModelicaStandardLibrary/pull/4073) (PR) Fix documentation of Modelica.Utilities.System.getTime()

### Miscellaneous

* [\#3728](https://github.com/modelica/ModelicaStandardLibrary/pull/3728) (PR) Fix Modelica.Utilities.Strings.hashString to always use provided HASH_AP and update 3rd-party header uthash to v2.3.0

