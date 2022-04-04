# The Comparison of Spatial Models
Comparing OLS (Ordinary Least Square), SCR (Spatial Cross Regressive), SAR (Spatial Autoregressive Model), SEM (Spatial Error Model), SDM (Spatial Durbin Model), and SDEM (Spatial Durbin Error Model) to modeling crime in Columbus.

# Result
# Description
Here are the pictures of Columbus's Maps and Columbus's group based on some indicators.

![image](https://user-images.githubusercontent.com/102334577/161647618-37ec5693-f113-4194-925a-11aeff2d339b.png)
![image](https://user-images.githubusercontent.com/102334577/161647649-aa66f78a-7b60-4a35-8f0f-9c416d916e7f.png)

# Comparing
The comparison of the model is checked by the AIC value. A model with the minimum of AIC is the model that we can use to spatial modeling the crime in Columbus.

    > AIC(reg.OLS)
    [1] 382.7489
    > AIC(reg.SLX) #SCR
    [1] 379.7961
    > AIC(reg.SAR) 
    [1] 379.7796
    > AIC(reg.SEM)
    [1] 380.8923
    > AIC(reg.SDM)
    [1] 380.517
    > AIC(reg.SDEM)
    [1] 381.3406
    
From the AIC value, we can see that the minimum of AIC is created by SAR model. So, the best model is SAR (Spatial Autoregressive Model).
Here are the results of SAR model.

    Lagrange multiplier diagnostics for spatial dependence
    data:
    model: lm(formula = reg.eq, data = spcolumb)
    weights: queen.columb
    LMlag = 6.5955, df = 1, p-value = 0.01022
    
Lm lag = 6,5955 with p-value = 0,01022 so we can conclude that SAR model is enough for modeling the ‘crime’ data.

    Call:lagsarlm(formula = reg.eq, data = spcolumb, listw = queen.columb)
    Residuals:
    Min 1Q Median 3Q Max
    -32.32594 -5.98879 0.94654 5.57831 24.23204
    Type: lag
    Coefficients: (asymptotic standard errors)
    Estimate Std. Error z value Pr(>|z|)
    (Intercept) 55.992385 7.111424 7.8736 3.553e-15
    data$income -1.529485 0.308456 -4.9585 7.103e-07
    data$housing -0.253738 0.094032 -2.6984 0.006967
    Rho: 0.30022, LR test value: 4.9693, p-value: 0.025801
    Asymptotic standard error: 0.13729
    z-value: 2.1867, p-value: 0.028765
    Wald statistic: 4.7816, p-value: 0.028765
    Log likelihood: -184.8898 for lag model
    ML residual variance (sigma squared): 108.55, (sigma: 10.419)
    Number of observations: 49
    Number of parameters estimated: 5
    AIC: 379.78, (AIC for lm: 382.75)
    LM test for residual autocorrelation
    test value: 0.030742, p-value: 0.86082
    
From output, we can build SAR model:
![image](https://user-images.githubusercontent.com/102334577/161649196-adc26a65-285c-414e-96cf-5aed500d36cd.png)

p-value in Wald test and prob(z-statistics) for all parameters < 0,05 so we can conlude that for all parameters are significant in α = 5%.
From the parameter coefficient output above we can interprate that 
1. The value of the spatial lag coefficient (𝜌 = 0.30022) means that the value of Crime in an area will increase by 0.30022 times the average Crime of an area that is a neighbour/direct contact with the area, assuming other variables are fixed.
2. The constant value of Crime is 55.992385 if the other parameters is zero.
3. Income contributes -1.529485 for this model or we can say that Income can gives decreasing of Crime value with the decrease every one point is 1.529485.
4. Housing contributes -0.253738 for this model or we can say that Housing can give decrease of Crime value with a decrease every one point is 0.253738.
