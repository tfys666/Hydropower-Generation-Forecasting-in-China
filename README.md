# Hydropower Generation Forecasting in China

This repository contains the analysis and forecasting of hydropower generation in China using time series analysis. The study focuses on the period from 1986 to 2022, with a specific emphasis on the months from March to December. The data for this study was sourced from the National Bureau of Statistics of China.

## Methods

The following methods were employed in the analysis:

1. **Factor Decomposition Model**: This model was used to decompose the time series data into trend, seasonal, and random effects.

2. **Holt-Winters Exponential Smoothing**: This three-parameter model was utilized to capture the trend and seasonal components of the time series data.

3. **ARIMA Multiplicative Model**: This model was chosen to account for the complex interactions between the seasonal, trend, and random effects in the data.

## Results

The analysis revealed a clear linear increasing trend and seasonal patterns in the hydropower generation data. Both the Holt-Winters and ARIMA models were used for forecasting, with the Holt-Winters model showing better performance in terms of prediction accuracy.

## Code Structure

The code is structured as follows:

- **Data Import**: The data is imported using the `readxl` package.
- **Time Series Object Creation**: A time series object is created with the imported data.
- **Decomposition**: The `decompose` function is used to decompose the time series.
- **Holt-Winters Model**: The `HoltWinters` function is applied to the time series data.
- **ARIMA Model**: The `arima` function is used to fit the ARIMA model.
- **Forecasting**: The `forecast` function from the `forecast` package is used for forecasting with both models.
- **Model Comparison**: The prediction performance of both models is compared using mean absolute error (MAE), mean squared error (MSE), and root mean squared error (RMSE).

## Dependencies

The following R packages are used in the analysis:

- `readxl`
- `forecast`
- `aTSA`
