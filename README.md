Title:

Football Player Data Shiny App with CRUD and Visualization

Overview:

This repository contains an R Shiny application for interactive management and exploration of a football players dataset. Users can create, read, update, and delete records and analyze the data with a scatter plot of Overall versus Potential and a histogram of Age. The application demonstrates reactive programming, data filtering, and exploratory visualization.

Features:

CRUD functionality to add, edit, and delete player records

Interactive data table with column filters and sorting

Plotly scatter plot to examine the relationship between Overall and Potential

ggplot2 histogram to study the distribution of player Age

Reactive filters for name search, nationality, and age range

Dataset:

The included CSV contains sample players and attributes such as Name, Nationality, Age, OVA, POT, Club, Height, Weight, Preferred Foot, and others. The schema aligns with the app inputs. 

Dataset for project

Requirements:

R version 4 or higher is recommended
Packages
shiny
DT
plotly
ggplot2

Getting Started

Clone or download this repository

Place the dataset file in the project root directory and ensure the file name in the code matches the dataset file name

Open R or RStudio in the project directory

Install required packages if needed

Run the app with the command
shiny::runApp()

Project Structure

app.R contains the full Shiny application code
Dataset for project.txt contains the sample dataset

How to Use:

Use the sidebar to add or update a record by entering values in the form and clicking Add Record or Update Record

Remove a record by entering the ID and clicking Delete Record

Filter the table and charts by entering a name, selecting a nationality, and adjusting the age range

Explore the scatter plot and histogram to understand relationships and distributions


application preview:
<img width="2554" height="1354" alt="image" src="https://github.com/user-attachments/assets/7d59d858-127c-4b3f-a688-be8d1d9395a4" />
<img width="2559" height="1204" alt="image" src="https://github.com/user-attachments/assets/ee1b6373-6561-4ad5-9ee8-8d13bee3dfdb" />



