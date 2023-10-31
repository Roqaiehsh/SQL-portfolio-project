SELECT*
FROM [portfolio project]..CovidDeaths1$
Where continent is not null
order by 3,4



SELECT*
FROM [portfolio project]..CovidVaccinations$
order by 3,4

--select data that we are going to be using


SELECT Country,date,total_cases,new_cases,total_deaths,population
FROM [portfolio project]..CovidDeaths1$
order by 1,2

--Looking at Total Cases Vs Total Deaths
--Shows likelihood of dying if you contract covid in your country 

SELECT Country,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM [portfolio project]..CovidDeaths1$
WHERE country like '%states%'
order by 1,2


Looking at Total Cases Vs Population
Shows what percentage of population got

SELECT Country,date,population,total_cases,(total_cases/population)*100 as populationPercentage
FROM [portfolio project]..CovidDeaths1$
--WHERE country like '%states%'
order by 1,2

Looking at Countries with Highest Infection Rate compared to Poulation

SELECT Country,population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentPopulationInfected
FROM [portfolio project]..CovidDeaths1$
--WHERE country like '%states%'
Where continent is not null
Group by Country,population
order by PercentPopulationInfected desc


--Showing Countries with Highest Death  Count per Population

Select Country, MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM [portfolio project]..CovidDeaths1$
--WHERE country like '%states%' 
Where continent is not null
Group by Country
order by TotalDeathCount desc


-- Lets Break Things Down By Continent

--Showing Continents with Highest Death Count per Population

Select continent, MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM [portfolio project]..CovidDeaths1$
--WHERE country like '%states%' 
Where continent is not null
Group by continent
order by TotalDeathCount desc

--Global Numbers

SELECT SUM(new_cases) as Total_Cases,SUM(Cast(new_deaths as int)) as Total_Deaths,Sum(Cast(new_deaths as int))/Sum(new_cases) as DeathPercentage
FROM [portfolio project]..CovidDeaths1$
--WHERE country like '%states%'
Where continent is not null
--Group by date
order by 1,2


--Looking at Total Population Vs Vaccinations

Select dea.continent,dea.Country,dea.date,dea.population,vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Country Order by dea.Country,dea.date)as RollingPeopleVaccinated
,--, (RollingPeopleVaccinated/population)*100
From [portfolio project]..CovidDeaths1$ dea
Join[portfolio project]..CovidVaccinations$ vac
   On dea.Country = vac.Countries
   and dea.date = vac.date
   Where dea.continent is not null
   Order by 2,3



  -- USE CDT

  with PopvsVac(continent,Country,date,population,new_vaccinations,RollingPeopleVaccinated)
  as
  (
  Select dea.continent,dea.Country,dea.date,dea.population,vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Country Order by dea.Country,dea.date)as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [portfolio project]..CovidDeaths1$ dea
Join[portfolio project]..CovidVaccinations$ vac
   On dea.Country = vac.Countries
   and dea.date = vac.date
 Where dea.continent is not null
-- Order by 2,3
)
Select *
From PopvsVac
   


   --TEMP TABLE

   Create Table PercentPopulationVaccinated(
   Continent nvarchar(255),
   Country nvarchar(255),
   Date datetime,
   Population numeric,
   New_Vaccinations numeric,
   RollingPeopleVaccinated numeric
   )

   Insert into  PercentPopulationVaccinated
    Select dea.continent,dea.Country,dea.date,dea.population,vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Country Order by dea.Country,dea.date)as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [portfolio project]..CovidDeaths1$ dea
Join[portfolio project]..CovidVaccinations$ vac
   On dea.Country = vac.Countries
   and dea.date = vac.date
 Where dea.continent is not null
-- Order by 2,3
Select *,(RollingPeopleVaccinated/population)*100
From PercentPopulationVaccinated



--Creating View to store data for later visualization

Create View  PopulationVaccinatedPercentage  as 
 Select dea.continent,dea.Country,dea.date,dea.population,vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Country Order by dea.Country,dea.date)as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [portfolio project]..CovidDeaths1$ dea
Join[portfolio project]..CovidVaccinations$ vac
   On dea.Country = vac.Countries
   and dea.date = vac.date
 Where dea.continent is not null
-- Order by 2,3

Select *
From PercentPopulationVaccinated