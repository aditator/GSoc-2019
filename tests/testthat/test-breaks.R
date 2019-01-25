devtools::use_testthat()
context("Breaks")
library(Segmentor3IsBack)
test_that("Segmentor@breaks returns expected value",{
  expect_equal(Segmentor(c(1,2,1),Kmax=3,model=1)@breaks,matrix(c(3,1,1,0,3,2,0,0,3),nrow = 3))
  expect_equal(Segmentor(c(1,1),Kmax=2,model=1)@breaks,matrix(c(2,2,0,2),nrow=2))
})
