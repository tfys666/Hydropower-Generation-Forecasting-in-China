df=readxl::read_excel("data.xlsx")
x=ts(df$q, start=c(1986,3),frequency=10)
plot(x)
#x11
x1.fit=decompose(x,type="multi")

x1.fit$figure
plot(x1.fit$figure,type="o")
x1.fit$trend
plot(x1.fit$trend)
x1.fit$random
plot(x1.fit$random)

plot(x)
lines(x1.fit$trend,col=2)

#Holt-Winters三参数指数平滑
x2.fit=HoltWinters(x,seasonal="mult")
x2.fit

library(forecast)
x2.fore=forecast::forecast(x2.fit, h=5)
x2.fore

plot(x2.fore,lty=2)
lines(x2.fore$fitted,col=4)

#ARIMA乘法模型
y=diff(diff(x,10))
plot(y)

library(aTSA)
adf.test(y,nlag=3)

for(k in 1:3) print(Box.test(y,lag=6*k,type="Ljung-Box"))

par(mfrow=c(1,2))
acf(y,lag=370)
pacf(y,lag=370)
acf(y,lag=40)
pacf(y,lag=40)

x3.fit=arima(x,order=c(2,1,2),seasonal=list(order=c(0,1,1),period=10))
x3.fit

ts.diag(x3.fit)

x3.fore=forecast::forecast(x3.fit, h=5)
par(mfrow=c(1,1))
plot(x3.fore,lty=2)
lines(fitted(x3.fit),col=4)

print(x2.fore$mean)
print(x3.fore$mean)

mae_x2=mean(abs(x2.fore$mean - df$q[1:5]))
mse_x2=mean((x2.fore$mean - df$q[1:5])^2)
rmse_x2=sqrt(mse_x2)
mae_x3=mean(abs(x3.fore$mean - df$q[1:5]))
mse_x3=mean((x3.fore$mean - df$q[1:5])^2)
rmse_x3=sqrt(mse_x3)
print(paste("Holt-Winters MAE:", mae_x2, "MSE:", mse_x2, "RMSE:", rmse_x2))
print(paste("ARIMA MAE:", mae_x3, "MSE:", mse_x3, "RMSE:", rmse_x3))

#auto_model
auto_model=auto.arima(x, seasonal = TRUE)
summary(auto_model)
x4.fore=forecast::forecast(auto_model, h=5)
mae_x4=mean(abs(x4.fore$mean - df$q[1:5]))
mse_x4=mean((x4.fore$mean - df$q[1:5])^2)
rmse_x4=sqrt(mse_x4)
print(paste("ARIMA MAE:", mae_x4, "MSE:", mse_x4, "RMSE:", rmse_x4))

#STL
stl_result <- stl(x, s.window = "periodic")
plot(stl_result)

detrended <- seasadj(stl_result)
detrended_model <- auto.arima(detrended)
final_model <- Arima(x, model = detrended_model)

