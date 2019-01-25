## 1. Easy Test

## Required Packages
The following packages are required to perform the segmentation.

```{r, message=FALSE}
#Load packages
if(!require(Segmentor3IsBack)){
install.packages(Segmentor3IsBack)
library(Segmentor3IsBack)
}

if(!require(neuroblastoma)){
install.packages(neuroblastoma)
library(neuroblastoma)
}

if(!require(PeakSegDP){
install.packages(PeakSegDP)
library(PeakSegDP)
}
```

## Extracting Data from desired packages and generating artificial datasets
```{r, message=FALSE}
#Getting the Data
data(chr11ChIPseq,package="PeakSegDP")
data(neuroblastoma,package="neuroblastoma")
w=c(rpois(200,4),rpois(200,1),rpois(200,2.2))  #Artificial Dataset with 3 different normal distributions of length 200 appended together
x=chr11ChIPseq$regions$chromStart
y=neuroblastoma$profiles$logratio[1:20]
z=c(1,2,2,1)
```
![alt tag](https://user-images.githubusercontent.com/37847118/51668016-41998f80-1fe7-11e9-9e6f-c242201aebf0.png)
```{r, message=FALSE}
#Generating Jumping Average Artificial Dataset
mu=function(n){
if(n==0){return(0)}
else{
return(mu(n-1)+(n/16)) }
}
muvect=vector()
for(i in 1:5){
muvect[i]=mu(i) }
q=vector()
q[1]=0
q[2]=0
for(i in 3:23){
q[i]=0.6*q[i-1]-0.5*q[i-2]+rnorm(200,muvect[1],1.5)[i] }
for(i in 24:44){
q[i]=0.6*q[i-1]-0.5*q[i-2]+rnorm(200,muvect[2],1.5)[i] }
for(i in 45:65){
q[i]=0.6*q[i-1]-0.5*q[i-2]+rnorm(200,muvect[3],1.5)[i] }
for(i in 66:86){
q[i]=0.6*q[i-1]-0.5*q[i-2]+rnorm(200,muvect[4],1.5)[i] }
for(i in 87:107){
q[i]=0.6*q[i-1]-0.5*q[i-2]+rnorm(200,muvect[5],1.5)[i] }
q=q[3:107]
```
![alt tag](https://user-images.githubusercontent.com/37847118/51668283-de5c2d00-1fe7-11e9-86ae-8600b13e75ad.png)
```{r, message=FALSE}
#Generating Moving Frequency Dataset
o=vector()
o[1]=1
for(i in 2:10){
  o[i]=o[i-1]*log(exp(1)+(i/2))
}
p=vector()
for(i in 1:50){
  p[i]=sin(o[1]*i)+rnorm(5000,0,0.8)[i]
}
for(i in 51:100){
  p[i]=sin(o[2]*i)+rnorm(5000,0,0.8)[i]
}
for(i in 101:150){
  p[i]=sin(o[3]*i)+rnorm(5000,0,0.8)[i]
}
for(i in 151:200){
  p[i]=sin(o[4]*i)+rnorm(5000,0,0.8)[i]
}
for(i in 201:250){
  p[i]=sin(o[5]*i)+rnorm(5000,0,0.8)[i]
}
```
## Applying the Segmentor and obtaining the change-points
```{r, message=FALSE}
#Performing Segmentation
w_seg=Segmentor(w,model=1,Kmax=5)
x_seg=Segmentor(x,model=1,Kmax=15)
y_seg=Segmentor(y,model=2,Kmax=5)
z_seg=Segmentor(z,model=1,Kmax=4)
q_seg=Segmentor(q,model = 2,Kmax = 6)
p_seg=Segmentor(p,Kmax = 6,model = 2)


#Getting Change Points
w_seg@breaks
x_seg@breaks
y_seg@breaks
z_seg@breaks
q_seg@breaks
p_seg@breaks
```
## Plotting
The vertical lines in the plots correspond to change-points.

```{r, message=FALSE}
#Plotting for case of 3 segments in W
plot(w)
abline(v=200,col="purple")
abline(v=400,col="purple")
abline(v=600,col="purple")
```
![alt tag](https://user-images.githubusercontent.com/37847118/49724995-b3fd1d00-fc90-11e8-8ceb-f6053178791c.png)


The algorithm gives the predicted set of change-points, i.e c(200,400,600).

```{r, message=FALSE}
#Plotting for case of 6 segments in X
plot(x)
abline(v=2,col="red")
abline(v=3,col="red")
abline(v=4,col="red")
abline(v=7,col="red")
abline(v=8,col="red")
abline(v=16,col="red")
```
![alt tag](https://user-images.githubusercontent.com/37847118/49725468-c035aa00-fc91-11e8-85b9-3dc6691584ec.png)
```{r, message=FALSE}
#Plotting for case of 5 segments in Y
plot(y)
abline(v=1,col="blue")
abline(v=7,col="blue")
abline(v=8,col="blue")
abline(v=11,col="blue")
abline(v=20,col="blue")
```
![alt tag](https://user-images.githubusercontent.com/37847118/49724993-b3648680-fc90-11e8-9729-41ccb76dc9fa.png)
```{r, message=FALSE}
#Plotting for case of 3 segments in Z (c(1,2,2,1))
plot(z)
abline(v=1,col="green")
abline(v=3,col="green")
abline(v=4,col="green")
```
![alt tag](https://user-images.githubusercontent.com/37847118/49724996-b3fd1d00-fc90-11e8-8738-1ff6e18725b2.png)

```{r, message=FALSE}
#Plotting for the case of 6 segments in moving average dataset
plot(q)
abline(v=53,col="purple")
abline(v=55,col="purple")
abline(v=58,col="purple")
abline(v=72,col="purple")
abline(v=105,col="purple")
```
![alt tag](https://user-images.githubusercontent.com/37847118/49730992-f2e69f00-fc9f-11e8-9399-7ed92760df07.png)


It is clearly observed that the algorithm fails to produce a valid set of change-points for the case of Jumping average artificial dataset.

```{r, message=FALSE}
#Plotting for the case of 5 segments in Changing Frequency dataset
plot(p)
abline(v=79,col="brown")
abline(v=80,col="brown")
abline(v=188,col="brown")
abline(v=189,col="brown")
abline(v=250,col="brown")
```
![alt tag](https://user-images.githubusercontent.com/37847118/49733254-05180b80-fca7-11e8-8070-bde62c471462.png)


The algorithm does not bring expected change-points.
