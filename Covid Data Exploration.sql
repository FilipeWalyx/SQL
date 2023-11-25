SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT *
FROM PortfolioProject..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Selecting the Data which will be used.
SELECT location, date, total_cases, new_cases, total_deaths, new_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

SELECT location, date, total_vaccinations, new_vaccinations
FROM PortfolioProject..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Total Cases vs Total Deaths.
-- What is the likelihood of dying if you contract Covid in your country daily?
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%angola%'
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- What is the likelihood of dying if you contract Covid in your continent daily?
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL AND location NOT IN('European Union','International','World')
ORDER BY 1,2;

-- Total Cases vs Population.
-- What percentage of the countries' population had gotten Covid daily?
SELECT location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
-- WHERE location like '%angola%'
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- What percentage of the continents' population has gotten Covid daily?
SELECT location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL AND location NOT IN('European Union','International','World')
ORDER BY 1,2;

-- Highest Infection Rate vs Population.
-- What percentage of each country's population has gotten Covid?
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,
	MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- What percentage of each continent's population has gotten Covid?
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,
	MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL AND location NOT IN('European Union','International','World')
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Highest Death Count vs Population.
-- What countries had the highest death count per population?
SELECT location, MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- What continents had the highest death count per population?
SELECT location, MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL AND location NOT IN('European Union','International','World')
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Global Numbers.
-- What is the global death percentage per day?
SELECT date, SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS int)) AS total_deaths,
	SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- What is the overall global death percentage?
SELECT SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS int)) AS total_deaths,
	SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL;

-- Population vs Vaccinations.
-- What is the total amount of people vaccinated in each country daily?
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations))
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- Creating a View to store data for later visualizations.
CREATE VIEW PercentageOfPopulationVaccinatedDaily AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations))
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
SELECT * FROM PercentageOfPopulationVaccinatedDaily;

-- What is the total percentage of people vaccinated in each country daily?
-- Creating a CTE.
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations))
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
) SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated FROM PopvsVac;

-- Creating a Temp Table.
DROP TABLE IF EXISTS #PercentPopulationVaccinated;
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
);
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations))
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated;

-- What countries were the most efficient at vaccinating their population?
DROP TABLE IF EXISTS #PopulationVaccinationPercentage;
CREATE TABLE #PopulationVaccinationPercentage
(
Location nvarchar(255),
Population numeric,
TotalPeopleVaccinated numeric,
);
INSERT INTO #PopulationVaccinationPercentage
SELECT dea.location, dea.population,
MAX(convert(int,vac.total_vaccinations)) AS TotalPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
WHERE dea.continent IS NOT NULL
GROUP BY dea.location, dea.population;
SELECT *, (TotalPeopleVaccinated/Population)*100 AS PercentageOfPeopleVaccinated
FROM #PopulationVaccinationPercentage ORDER BY PercentageOfPeopleVaccinated DESC;
