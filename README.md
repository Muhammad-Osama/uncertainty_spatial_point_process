# uncertainty_spatial_point_process
Given events across space **x** (e.g. crime locations across a city), the code above can be used to obtain intensity interval \Lambda(**x**) across space (in e.g. crimes per unit area) which have valid coverage even under model misspecification. One can also obtain a point estimate \widehat{\lambda(**x**)} of the intensity function across space. Moreover, one can also predict the number of counts *y* in a given spatial region and get an interval with valid coverage in units of counts.  For details, see M. Osama, Dave Zachariah, Peter Stoica, "Prediction of Spatial Point Processes: Regularized Method with Out-of-Sample Guarantees", NeurIPS 2019.


