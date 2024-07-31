
# Predictive Models for "Any Outcome" and "Major Outcome"

## Overview

This Shiny application provides predictive models for "Any Outcome" and "Major Outcome" using logistic regression. The models are designed to assess potential predictive variables and provide performance metrics such as overall model fit, discrimination, and calibration.

## Installation

To run the application, follow these steps:

### Prerequisites

Ensure you have R and RStudio installed. Install the required packages by running the following command in R:

```R
install.packages(c("shiny", "tidyverse", "caret", "pROC", "boot", "shinythemes", "DT"))
```

### Running the App

Clone the repository or download the app files to your local machine. Open the `app.R` file in RStudio and click on the "Run App" button.

Alternatively, you can run the app using the command:

```R
shiny::runApp("path/to/your/app")
```

Replace `"path/to/your/app"` with the actual path to the app directory.

## Using the Application

### Inputs

The app allows users to input the values for the variables used in the prediction models. The variables include:

- Age
- Gender (Female or Male)
- Path (options: DEFORMITY, DEGEN, INFECTION, TRAUMA)
- Anemia (Yes or No)
- Autoimmune (Yes or No)
- Respiratory (Yes or No)
- Cardiac (Yes or No)
- Diabetic (Yes or No)
- Invasiveness

### Outputs

The app provides predictions for the probability of "Any Outcome" and "Major Outcome" based on the input values. The outputs include:

- Predicted probability for "Any Outcome"
- Predicted probability for "Major Outcome"
