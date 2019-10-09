# Prediction of Spatial Point Process
Given events across space **x** (e.g. crime locations across a city), the code above can be used to obtain intensity interval \Lambda(**x**) across space (in e.g. crimes per unit area) which have valid coverage even under model misspecification. One can also obtain a point estimate \widehat{\lambda(**x**)} of the intensity function across space. Moreover, one can also predict the number of counts *y* in a given spatial region and get an interval with valid coverage in units of counts.  For details, see *M. Osama, Dave Zachariah, Peter Stoica*, **Prediction of Spatial Point Processes: Regularized Method with Out-of-Sample Guarantees**, *NeurIPS 2019.*

## Example: Crime data
The figures below show the point estimate of intensity and the upper and lower limits of the intensity interval in crimes per sq. km for crime locations (crosses in figures) in Portland, USA. Note that the interval size is large where there is no data (e.g. upper left corner).

![crime_point_inten](https://user-images.githubusercontent.com/37805794/66397460-29826880-e9dc-11e9-92bc-2fbb69f652d4.png)
![crime_upper_limit](https://user-images.githubusercontent.com/37805794/66397467-2dae8600-e9dc-11e9-996e-07e38cb2eb43.png)
![crime_lower_limit](https://user-images.githubusercontent.com/37805794/66397471-30a97680-e9dc-11e9-9d8a-f75d37559489.png)


## Description of code
#### pred_int_1D_syn.m
This script demonstrates the functionality of our code in 1D space with an exponentially decaying intensity function. The events are sampled from an inhomegeneous Poisson process using inversion sampling. The functions used inside the script are also given and have a detailed description of the INPUTs and OUTPUTs in their function definition. (You can simply run the script to get an idea)

#### hickory.m
This script demonstrates the functionality of our code in 2D space using real data of hickory tree locations. The data is also attached in the csv file. In 2D, we use hexagonal gridding and the sub-functions to do that are also provided. (You can simply run the script to get an idea).

