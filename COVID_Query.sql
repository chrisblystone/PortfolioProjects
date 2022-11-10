SELECT 
location,date,total_cases, new_cases,total_deaths,population
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
ORDER BY 1,2;

-- Looking at total cases vs total deaths

SELECT 
location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS death_percentage 
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
ORDER BY 1,2;

-- Looking at total cases vs population

SELECT 
location,date,total_cases, population, (total_cases/population)*100 AS infection_percentage 
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
ORDER BY 1,2;

-- Looking at United States infection percentage by date

SELECT 
location,date,total_cases, population, (total_cases/population)*100 AS infection_percentage 
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null AND location = 'United States'
ORDER BY 1,2;

--Looking at highest infection rates by country

SELECT 
location,MAX(total_cases) AS peak_infection_count, population, MAX((total_cases/population))*100 AS infection_percentage 
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
GROUP BY 
population, location
ORDER BY infection_percentage DESC;

-- Showing highest death totals by country per population

SELECT 
location,MAX(total_deaths) AS total_death_count
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
GROUP BY 
location
ORDER BY total_death_count DESC;

-- Shows total deaths by continent and globally

SELECT location
location,MAX(total_deaths) AS total_death_count
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is null
GROUP BY 
location
ORDER BY total_death_count DESC;

-- Shows global covid infections by date

SELECT 
date,SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS global_death_percentage 
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

--Total cases, deaths, and death percentage globally

SELECT 
SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS global_death_percentage 
FROM
`covid-data-project-368212.covid.coviddeaths`
WHERE continent is not null
ORDER BY 1,2;

-- Total population vs vaccinated population

SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS current_population_vaccinated
FROM `covid-data-project-368212.covid.coviddeaths` dea
JOIN `covid-data-project-368212.covid.covidvaccinations` vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent is not null  
ORDER BY 2,3;