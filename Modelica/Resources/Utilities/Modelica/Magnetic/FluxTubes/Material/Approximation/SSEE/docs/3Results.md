## Result: struct par of SSEE

```
- material name of material
- HD       array of measured field strength
- JD       array of measured polarization
- mu_rD    relative permeability of raw data
- mu_rdD   relative differential permeabiility of raw data
- vRef     specific losses
- BRef     vRef measured with peak flux density Bref
- fRef     vRef measured with frequency fRef
- dens     density of material
- k0       index of raw data field strength where exponential extrapolation is based
- hH1      field strength where switch-over from smoothed splines to exponential extrapolation starts
- hH2      field strength where switch-over from smoothed splines to exponential extrapolation ends
- mu_ri    calculated initial relative permeability
- Jsat     calculated saturation polarization
- Hsat     calculated field strength to reach Jsat with an error of 1 ppm
- Hpar     parameter for exponential extrapolation
- pp       struct containing the parameters of the smoothing splines
- dpp      struct containing the parameters of the derivatives of the smoothing splines
- H_muMax  field strength at maximum permeability
- J_muMax  polarization at maximum permeability
- B_muMax  flux density at maximum permeability
- mu_rMax  maximum relative permeability
```

### Figures:

1. J(H) over the whole measured H-range with logarithmic x-axis.

2. J(H) over a limited range with linear axes to show the behaviour near the origin. The axis limits can be adapted manually.

3. &mu;<sub>r</sub> relative permeability and &mu;<sub>rd</sub> differential relative permeability over the whole measured H-range with double logarithmic axes.

4. &mu;<sub>r</sub> relative permeability and &mu;<sub>rd</sub> differential relative permeability over a limited range with linear axes to show the behaviour near the origin. The axis limits can be adapted manually.

### Note:

&mu;<sub>rd</sub> differential relative permeability of rawData is calculated with difference quotients and therefore strongly dependent on
accuracy of measurements and distance &Delta;H of measurements.
