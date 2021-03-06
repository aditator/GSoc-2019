## Writing a Unit Test on Windows
```{r, message=false}
usethis::use_testthat()
library(testthat)
context("Breaks")
library(Segmentor3IsBack)
test_that("Segmentor@breaks returns expected value",{
  M1=Segmentor(c(1,2,1),Kmax=3,model=1)@breaks
  N1=rbind(c(3,0,0),
           c(1,3,0),
           c(1,2,3))
  colnames(M1)=NULL
  row.names(M1)=NULL
  M2=Segmentor(c(1,1),Kmax=2,model=1)@breaks
  N2=rbind(c(2,0),
           c(2,2))
  colnames(M2)=NULL
  row.names(M2)=NULL
  expect_equal(M1,N1,check.attributes=FALSE)
  expect_equal(M2,N2+1,check.attributes=FALSE)
})
```

It can be seen here that the first test passes but the second test fails on Windows.
![alt tag](https://user-images.githubusercontent.com/37847118/52407757-222a5880-2af7-11e9-8413-acf0504b5600.PNG)

## Win-builder Check Log Results (Cropped to Specifics)
![alt tag](https://user-images.githubusercontent.com/37847118/53681486-40f3c780-3d10-11e9-8169-c739e1e7d82f.PNG)
