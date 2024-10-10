set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2
probl = hw2[!is.na(hw2)]
probl = probl[probl>=14]
probl = probl[probl<=38]
times3 = probl * 3
plus10 = times3 + 10
final = plus10[c(1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23)]
final
