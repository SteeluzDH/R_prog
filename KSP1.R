library("readxl")
library("ggplot2")
library("car")
library("caret")

file <- "C:\\Users\\david\\Documents\\skola\\githubs\\r_prog_ds23-main\\kunskapskontroll\\datainsamlingblocket.xlsx"
bildata <- read_excel(file, range = "A1:I2727")

View(bildata)
names(bildata)
geom_point()

sapply(bildata, class)
sum(is.na(bildata))
bildata[is.na(bildata)] <- 0

bildata$Pris <- as.numeric(bildata$Pris)
bildata$Bränsle <- as.factor(bildata$Bränsle)
bildata$Växellåda <- as.factor(bildata$Växellåda)
bildata$Miltal <- as.numeric(bildata$Miltal)
bildata$Modellår <- as.numeric(bildata$Modellår)
bildata$Biltyp <- as.factor(bildata$Biltyp)
bildata$Drivning <- as.factor(bildata$Drivning)
bildata$Hästkrafter <- as.numeric(bildata$Hästkrafter)
bildata$Märke <- as.factor(bildata$Märke)

# Hitta duplicerade rader
duplicates <- duplicated(bildata)

# Visa duplicerade rader
bildata[duplicates, ]
# Ta bort duplicerade rader och behåll endast unika rader
bildata_unique <- bildata[!duplicated(bildata), ]

# Kontrollera antalet rader före och efter borttagningen
cat("Antal rader före borttagning:", nrow(bildata), "\n")
cat("Antal rader efter borttagning:", nrow(bildata_unique), "\n")


# Dela in data i tränings- och testuppsättningar (t.ex. 80% för träning och 20% för test)
set.seed(123) # För att göra delningen reproducibel
trainIndex <- createDataPartition(bildata$Pris, p = 0.8, list = FALSE)
data_train <- bildata[trainIndex, ]
data_test <- bildata[-trainIndex, ]

# Kontrollera storleken på tränings- och testuppsättningarna
nrow(data_train)
nrow(data_test)





mdl <- lm(Pris~ Växellåda + Bränsle
          + Miltal + Modellår + Biltyp + Drivning
          + Hästkrafter + Märke, data_train)
par(mfrow=c(2,2))
summary(mdl)
vif(mdl)

plot(mdl) + geom_smooth(method="lm", col="red")


plot(bildata$Pris ~ bildata$Märke)
# Importerar ny slumpmässig data
# pris: 209 500 kr
nybil <- data.frame(Bränsle = "bensin",
                    Växellåda = "manuell",
                    Miltal = 100,
                    Modellår = 2023,
                    Biltyp = "suv",
                    Drivning = "tvåhjulsdriven",
                    Hästkrafter = 96,
                    Märke = "volkswagen")



#skapar en prediktion 
pred <- predict(mdl, newdata = data_test, interval = "confidence")


pred2 <- predict(mdl, newdata = nybil, interval = "confidence")

pred2

#Beräknar RSME
residuals <- pred - data_test$Pris

mse <- mean(residuals^2)

rmse <- sqrt(mse)

mse
rmse


