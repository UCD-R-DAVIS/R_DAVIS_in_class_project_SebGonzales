# Week 2 Intro to R - 10/3/24

#Intro to R: Arithmetic

3+4 #[1] denotes numb of things we're outputting

#Order of operations
4+8*3^2

#scientific notation
2/1000
4e2

#mathematical functions
exp(1)
log(4)
sqrt(4)

#r help files
?log
log(2,4)
log(x=2, base=4) #x= and base= aren't necesarry, but helps to label your script so it's more readible for others and replicable for yourself

x <- 1 #establish x=1 in env
rm(x) #removes x from env

#nested functions work from the inside out
#six comparison functions
mynumber<-6 #establishes my number
mynumber==5 #asks if 'mynumber' is equal to 6, '==' asks if it's true, '=' or '<-' sets value in environment
mynumber!=5 #asks if 'mynumber' different than 5
othernumber<--3
mynumber*othernumber
ls() #shows all variables in environmnet
rm(list=ls()) #removes all values form environment 

#errors and warnings
log("a_word")
log_of_word <- log("a_word")
log_of_word

log_of_negative <- log(-2)
log_of_negative #warning messages are mega dangerous bc they allow us to keep going, errors will actually stop you

#challenge
elephant1_kg <- 3492
elephant2_lb <- 7757
elephant1_lb = elephant1_kg * 2.2
elephant1_lb > elephant2_lb
myelephants = c(elephant1_lb, elephant2_lb)
which(myelephants == max(myelephants))
