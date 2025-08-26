## Breast Cancer Prediction Modeling using Logistic Regression


### Introduction

#### This script builds a logistic regression model to predict breast cancer diagnosis (malignant or benign) based on various features.


### *Loading required packages*

pacman::p_load(tidyverse,caret,caTools,pROC,ROCR,GGally,knitr,stats,reshape2)


### *Load the Dataset*

data <- read.csv("data.csv")  # Replace with the actual path to your dataset

head(data)

### Data Preprocessing and Cleaning

#### *Check for missing values*

sum(is.na(data))

### Remove rows with missing values (if any)

data <- na.omit(data)

### Convert categorical variables to factors

data$diagnosis <- as.factor(data$diagnosis)  # Assuming 'diagnosis' is the target variable   

### Drop unnecessary columns (like ID)

data <- data %>% select(-id) # Replace 'id' with the actual column name    

str(data)
   

### Exploratory Data Analysis (EDA)


### Summary statistics

summary(data)  

### Visualize the distribution of the target variable

ggplot(data, aes(x = diagnosis)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Breast Cancer Diagnosis", x = "Diagnosis", y = "Count")   


### Pairwise scatter plots to visualize relationships between features
ggpairs(data, aes(color = diagnosis, alpha = 0.5)) +
  labs(title = "Pairwise Scatter Plots of Features")

### Correlation matrix
cor_matrix <- cor(data %>% select(-diagnosis)) # Exclude target variable

     
melted_cor <- melt(cor_matrix)
ggplot(melted_cor, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       limit = c(-1, 1), name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 9, hjust = 1)) +
  coord_fixed() +
  labs(title = "Correlation Matrix of Features")    


### Split the Data into Training and Testing Sets


set.seed(123) # For reproducibility 

split <- sample.split(data$diagnosis, SplitRatio = 0.7) # 70% training, 30% testing

train_data <- subset(data, split == TRUE)   

test_data <- subset(data, split == FALSE)

dim(train_data)

dim(test_data)  


### Build the Logistic Regression Model


### Fit the logistic regression model


logistic_model <- glm(diagnosis ~ ., data = train_data, family = binomial)


summary(logistic_model) 

### Predict on the test set


test_data$predicted_prob <- predict(logistic_model, newdata = test_data, type = "response")

test_data$predicted_class <- ifelse(test_data$predicted_prob > 0.5, "M", "B") # Assuming 'M' for malignant and 'B' for benign

test_data$predicted_class <- as.factor(test_data$predicted_class)   

### Confusion Matrix


confusion_matrix <- confusionMatrix(test_data$predicted_class, test_data$diagnosis)     


print(confusion_matrix) 

### Accuracy, Precision, Recall

accuracy <- confusion_matrix$overall['Accuracy']

precision <- confusion_matrix$byClass['Pos Pred Value']

recall <- confusion_matrix$byClass['Sensitivity']

cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")

### ROC Curve and AUC

roc_curve <- roc(test_data$diagnosis, test_data$predicted_prob, levels = c("B", "M"))
plot(roc_curve, col = "blue", main = "ROC Curve")
auc_value <- auc(roc_curve)


cat("AUC:", auc_value, "\n")

