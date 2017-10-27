
library(rjags)

ms = "
model {
  alpha ~ dbeta(s*t, s*(1-t))
  y ~ dbinom(alpha,n) 
}"

data_to_model = list(s=2, t = 0.5, 
                     n = 10, y = 2)

attach(data_to_model)
m = jags.model(textConnection(ms), data=data_to_model, 
               n.adapt = 10^6, n.chains=3)
sam = coda.samples(m, c('alpha'), n.iter=10000, thin=1)
plot(sam)
summary(sam)

# conjugate distribution
# posterior mean
(s*t+y) / ((s*t+y) + (s*(1-t)+(n-y)))
