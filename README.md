[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/G-eAxnks)

Project Overview

The project is designed to facilitate the organization and tracking of tree planting activities, including volunteer participation, permit statuses, and tree planting records.  

It includes tables and operations for managing volunteers, permits, tree requests, tree plantings, and site visits. 

Database Structure

The database consists of the following main tables:  
volunteers: Stores information about volunteers, including their ID, application status, and availability.

permits: Contains data about permits, including permit ID, related request ID, status, and issue date.

treeRequests: Manages tree planting requests with details such as reference number, address, payment amount, relationship to property, and request status.

treePlantings: Records information about tree planting events, including plant ID, request reference number, event name, plant date, and tree species.

volunteerPlants: Tracks volunteer participation in tree planting events, including work hours and feedback.

plantingZones: Defines different planting zones with various attributes.
trees: Contains information about different tree species, including common and scientific names, height, width, and other characteristics.

siteVisits: Logs site visits for tree planting requests, including visit date, status, address, and related request reference number.

recommendedTrees: Stores recommended trees for specific site visits.

