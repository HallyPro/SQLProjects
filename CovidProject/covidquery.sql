IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CovidProject')
    BEGIN
        ALTER DATABASE CovidProject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE CovidProject
    END;
GO

CREATE DATABASE CovidProject
GO

USE CovidProject
GO

-->> Creating and loading Vacination data
    IF OBJECT_ID('covid_vaccination', 'U') IS NOT NULL
        DROP TABLE covid_vaccination
    GO
    CREATE TABLE covid_vaccination(
        iso_code VARCHAR(10),
        continent VARCHAR(50),
        [location] VARCHAR(100),
        [date] VARCHAR(20),
        new_tests VARCHAR(50),
        total_tests VARCHAR(50),
        total_tests_per_thousand VARCHAR(50),
        new_tests_per_thousand VARCHAR(50),
        new_tests_smoothed VARCHAR(50),
        new_tests_smoothed_per_thousand VARCHAR(50),
        positive_rate VARCHAR(50),
        tests_per_case VARCHAR(50),
        tests_units VARCHAR(50),
        total_vaccinations VARCHAR(50),
        people_vaccinated VARCHAR(50),
        people_fully_vaccinated VARCHAR(50),
        new_vaccinations VARCHAR(50),
        new_vaccinations_smoothed VARCHAR(50),
        total_vaccinations_per_hundred VARCHAR(50),
        people_vaccinated_per_hundred VARCHAR(50),
        people_fully_vaccinated_per_hundred VARCHAR(50),
        new_vaccinations_smoothed_per_million VARCHAR(50),
        stringency_index VARCHAR(50),
        population_density VARCHAR(50),
        median_age VARCHAR(50),
        aged_65_older VARCHAR(50),
        aged_70_older VARCHAR(50),
        gdp_per_capita VARCHAR(50),
        extreme_poverty VARCHAR(50),
        cardiovasc_death_rate VARCHAR(50),
        diabetes_prevalence VARCHAR(50),
        female_smokers VARCHAR(50),
        male_smokers VARCHAR(50),
        handwashing_facilities VARCHAR(50),
        hospital_beds_per_thousand VARCHAR(50),
        life_expectancy VARCHAR(50),
        human_development_index VARCHAR(50)
    );

    TRUNCATE TABLE covid_vaccination
    GO
    BULK INSERT covid_vaccination
    FROM '/var/opt/mssql/Covid_project/CovidvacinationsCSV.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0d0a',
        TABLOCK
    );

    SELECT
        *
    FROM covid_vaccination
    GO

-->> Cleaning and converting data types >> COVID_VACCINATION
    SELECT
        iso_code,
        continent,
        [location],
        TRY_CONVERT(DATE, [date], 103) AS  [date],
        TRY_CONVERT(INT, new_tests) AS  new_tests,
        TRY_CONVERT(INT, total_tests) AS  total_tests,
        TRY_CONVERT(FLOAT, total_tests_per_thousand) AS  total_tests_per_thousand,
        TRY_CONVERT(FLOAT, new_tests_per_thousand) AS  new_tests_per_thousand,
        TRY_CONVERT(INT, new_tests_smoothed) AS  new_tests_smoothed,
        TRY_CONVERT(FLOAT, new_tests_smoothed_per_thousand) AS  new_tests_smoothed_per_thousand,
        TRY_CONVERT(FLOAT, positive_rate) AS  positive_rate,
        TRY_CONVERT(FLOAT, tests_per_case) AS  tests_per_case,
        tests_units,
        TRY_CONVERT(INT, total_vaccinations) AS  total_vaccinations,
        TRY_CONVERT(INT, people_vaccinated) AS  people_vaccinated,
        TRY_CONVERT(INT, people_fully_vaccinated) AS  people_fully_vaccinated,
        TRY_CONVERT(INT, new_vaccinations) AS  new_vaccinations,
        TRY_CONVERT(INT, new_vaccinations_smoothed) AS  new_vaccinations_smoothed,
        TRY_CONVERT(FLOAT, total_vaccinations_per_hundred) AS  total_vaccinations_per_hundred,
        TRY_CONVERT(FLOAT, people_vaccinated_per_hundred) AS  people_vaccinated_per_hundred,
        TRY_CONVERT(FLOAT, people_fully_vaccinated_per_hundred) AS  people_fully_vaccinated_per_hundred,
        TRY_CONVERT(INT, new_vaccinations_smoothed_per_million) AS  new_vaccinations_smoothed_per_million,
        TRY_CONVERT(FLOAT, stringency_index) AS  stringency_index,
        TRY_CONVERT(FLOAT, population_density) AS  population_density,
        TRY_CONVERT(FLOAT, median_age) AS  median_age,
        TRY_CONVERT(FLOAT, aged_65_older) AS  aged_65_older,
        TRY_CONVERT(FLOAT, aged_70_older) AS  aged_70_older,
        TRY_CONVERT(FLOAT, gdp_per_capita) AS  gdp_per_capita,
        TRY_CONVERT(FLOAT, extreme_poverty) AS  extreme_poverty,
        TRY_CONVERT(FLOAT, cardiovasc_death_rate) AS  cardiovasc_death_rate,
        TRY_CONVERT(FLOAT, diabetes_prevalence) AS  diabetes_prevalence,
        TRY_CONVERT(FLOAT, female_smokers) AS  female_smokers,
        TRY_CONVERT(FLOAT, male_smokers) AS  male_smokers,
        TRY_CONVERT(FLOAT, handwashing_facilities) AS  handwashing_facilities,
        TRY_CONVERT(FLOAT, hospital_beds_per_thousand) AS  hospital_beds_per_thousand,
        TRY_CONVERT(FLOAT, life_expectancy) AS  life_expectancy,
        TRY_CONVERT(FLOAT, human_development_index) AS  human_development_index
    FROM covid_vaccination

    UPDATE covid_vaccination
    SET [date] = CONVERT(VARCHAR(10), TRY_CONVERT(DATE, [date], 103), 23);

    ALTER TABLE covid_vaccination ALTER COLUMN [date] DATE;
    ALTER TABLE covid_vaccination ALTER COLUMN new_tests INT;
    ALTER TABLE covid_vaccination ALTER COLUMN total_tests INT;
    ALTER TABLE covid_vaccination ALTER COLUMN total_tests_per_thousand FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN new_tests_per_thousand FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN new_tests_smoothed INT;
    ALTER TABLE covid_vaccination ALTER COLUMN new_tests_smoothed_per_thousand FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN positive_rate FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN tests_per_case FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN total_vaccinations INT;
    ALTER TABLE covid_vaccination ALTER COLUMN people_vaccinated INT;
    ALTER TABLE covid_vaccination ALTER COLUMN people_fully_vaccinated INT;
    ALTER TABLE covid_vaccination ALTER COLUMN new_vaccinations INT;
    ALTER TABLE covid_vaccination ALTER COLUMN new_vaccinations_smoothed INT;
    ALTER TABLE covid_vaccination ALTER COLUMN total_vaccinations_per_hundred FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN people_vaccinated_per_hundred FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN people_fully_vaccinated_per_hundred FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN new_vaccinations_smoothed_per_million INT;
    ALTER TABLE covid_vaccination ALTER COLUMN stringency_index FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN population_density FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN median_age FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN aged_65_older FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN aged_70_older FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN gdp_per_capita FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN extreme_poverty FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN cardiovasc_death_rate FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN diabetes_prevalence FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN female_smokers FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN male_smokers FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN handwashing_facilities FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN hospital_beds_per_thousand FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN life_expectancy FLOAT;
    ALTER TABLE covid_vaccination ALTER COLUMN human_development_index FLOAT;

    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        CHARACTER_MAXIMUM_LENGTH,
        NUMERIC_PRECISION,
        NUMERIC_SCALE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'covid_vaccination'
GO

--------------------------------------------------------------------------------------------------------------------------------------------------
-->> Creating and loading the covid data
    IF OBJECT_ID('covid_staging', 'U') IS NOT NULL
        DROP TABLE covid_staging
    GO
    CREATE TABLE covid_staging(
        iso_code VARCHAR(10),
        continent VARCHAR(50),
        [location] VARCHAR(100),
        [date] VARCHAR(20),
        [population] VARCHAR(50),
        total_cases VARCHAR(50),
        new_cases VARCHAR(50),
        new_cases_smoothed VARCHAR(50),
        total_deaths VARCHAR(50),
        new_deaths VARCHAR(50),
        new_deaths_smoothed VARCHAR(50),
        total_cases_per_million VARCHAR(50),
        new_cases_per_million VARCHAR(50),
        new_cases_smoothed_per_million VARCHAR(50),
        total_deaths_per_million VARCHAR(50),
        new_deaths_per_million VARCHAR(50),
        new_deaths_smoothed_per_million VARCHAR(50),
        reproduction_rate VARCHAR(50),
        icu_patients VARCHAR(50),
        icu_patients_per_million VARCHAR(50),
        hosp_patients VARCHAR(50),
        hosp_patients_per_million VARCHAR(50),
        weekly_icu_admissions VARCHAR(50),
        weekly_icu_admissions_per_million VARCHAR(50),
        weekly_hosp_admissions VARCHAR(50),
        weekly_hosp_admissions_per_million VARCHAR(50)
    );

    TRUNCATE TABLE covid_staging
    GO
    BULK INSERT covid_staging
            FROM '/var/opt/mssql/Covid_project/CovidDeathsCSV.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '0x0d0a',
                TABLOCK
            );

    SELECT * FROM covid_staging;
    GO

-->> Cleaning and converting data types >> COVID_DEATHS
    SELECT
        iso_code,
        continent,
        [location],
        TRY_CONVERT(DATE, [date], 103) AS  [date],
        TRY_CONVERT(BIGINT, [population]) AS [population],
        TRY_CONVERT(BIGINT, total_cases) AS total_cases,
        TRY_CONVERT(INT, new_cases) AS new_cases,
        TRY_CONVERT(FLOAT, new_cases_smoothed) AS new_cases_smoothed,
        TRY_CONVERT(FLOAT, total_deaths) AS total_deaths,
        TRY_CONVERT(FLOAT, new_deaths) AS new_deaths,
        TRY_CONVERT(FLOAT, new_deaths_smoothed) AS new_deaths_smoothed,
        TRY_CONVERT(FLOAT, total_cases_per_million) AS total_cases_per_million,
        TRY_CONVERT(FLOAT, new_cases_per_million) AS new_cases_per_million,
        TRY_CONVERT(FLOAT, new_cases_smoothed_per_million) AS new_cases_smoothed_per_million,
        TRY_CONVERT(FLOAT, total_deaths_per_million) AS total_deaths_per_million,
        TRY_CONVERT(FLOAT, new_deaths_per_million) AS new_deaths_per_million,
        TRY_CONVERT(FLOAT, new_deaths_smoothed_per_million) AS new_deaths_smoothed_per_million,
        TRY_CONVERT(FLOAT, reproduction_rate) AS reproduction_rate,
        TRY_CONVERT(INT, icu_patients) AS icu_patients,
        TRY_CONVERT(FLOAT, icu_patients_per_million) AS icu_patients_per_million,
        TRY_CONVERT(INT, hosp_patients) AS hosp_patients,
        TRY_CONVERT(FLOAT, hosp_patients_per_million) AS hosp_patients_per_million,
        TRY_CONVERT(FLOAT, weekly_icu_admissions) AS weekly_icu_admissions,
        TRY_CONVERT(FLOAT, weekly_icu_admissions_per_million) AS weekly_icu_admissions_per_million,
        TRY_CONVERT(FLOAT, weekly_hosp_admissions) AS weekly_hosp_admissions,
        TRY_CONVERT(FLOAT, weekly_hosp_admissions_per_million) AS weekly_hosp_admissions_per_million
    FROM covid_staging

    SELECT
        REPLACE(REPLACE(weekly_hosp_admissions_per_million, CHAR(13), ''), CHAR(10), '')
    FROM covid_staging

    UPDATE covid_staging
    SET weekly_hosp_admissions_per_million = REPLACE(REPLACE(weekly_hosp_admissions_per_million, CHAR(13), ''), CHAR(10), '');

    UPDATE covid_staging
    SET [date] = CONVERT(VARCHAR(10), TRY_CONVERT(date, [date], 103), 23);

    ALTER TABLE covid_staging ALTER COLUMN [date] DATE;
    ALTER TABLE covid_staging ALTER COLUMN [population] BIGINT;
    ALTER TABLE covid_staging ALTER COLUMN total_cases BIGINT;
    ALTER TABLE covid_staging ALTER COLUMN new_cases INT;
    ALTER TABLE covid_staging ALTER COLUMN new_cases_smoothed FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN total_deaths FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN new_deaths FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN new_deaths_smoothed FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN total_cases_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN new_cases_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN new_cases_smoothed_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN total_deaths_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN new_deaths_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN new_deaths_smoothed_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN reproduction_rate FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN icu_patients INT;
    ALTER TABLE covid_staging ALTER COLUMN icu_patients_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN hosp_patients INT;
    ALTER TABLE covid_staging ALTER COLUMN hosp_patients_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN weekly_icu_admissions FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN weekly_icu_admissions_per_million FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN weekly_hosp_admissions FLOAT;
    ALTER TABLE covid_staging ALTER COLUMN weekly_hosp_admissions_per_million FLOAT;

    SELECT
        REPLACE(REPLACE(weekly_hosp_admissions_per_million, CHAR(13), ''), CHAR(10), '')
    FROM covid_staging

    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        CHARACTER_MAXIMUM_LENGTH,
        NUMERIC_PRECISION,
        NUMERIC_SCALE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'covid_staging'
    -- OR >>
    EXEC sp_help 'covid_staging'
GO

--------------------------------------------------------------------------------------------------------------------------------------------------
-->> Exploration and Analysis
    -- Looking at total cases vs total deaths
    -- Exploring the death rate
    SELECT
        [location],
        date,
        total_cases,
        total_deaths,
        Cast(total_deaths AS DECIMAL(18,2))/total_cases *100 AS DeathPercentage
    FROM covid_staging
    WHERE location LIKE '%states%'
    ORDER BY 1,2

    -- Looking at total cases vs population 
    -- Shows percentage of population was infected with Covid
    SELECT
        [location],
        date,
        total_cases,
        population,
        CAST((CAST(total_cases AS DECIMAL(18,0))/population)*100 AS DECIMAL(10,3))AS Case_Pop_Pct
    FROM covid_staging
    WHERE location = 'Nigeria'
    ORDER BY 1,2

    -- Checking the countries with highest infection rate
    SELECT
        location,
        population,
        MAX(total_cases) AS highestInfetionCount,
        CAST( MAX(CAST(total_cases AS DECIMAL(18,0))/ population)*100 AS DECIMAL(10,2))AS Case_Pop_Pct
     FROM covid_staging
     WHERE continent IS NOT NULL
     GROUP BY location, population
     ORDER BY Case_Pop_Pct DESC
    

    -- Checking countries with highest death count
    SELECT
        location,
        MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
     FROM covid_staging
     WHERE continent IS NOT NULL
     GROUP BY location
     ORDER BY TotalDeathCount DESC    

    -- Checking countries with highest death count per continent 
    SELECT
        [location],
        MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
     FROM covid_staging
     WHERE continent IS NULL
     GROUP BY [location]
     ORDER BY TotalDeathCount DESC    
    
    -- Checking the gloabal numbers
    SELECT 
        [date], 
        SUM(new_cases) AS TotalCase,
        SUM(new_deaths) AS TotalDeaths,
        (SUM(new_deaths)/NULLIF(SUM(new_cases), 0)) * 100 AS DeathPercentage
     FROM covid_staging
     WHERE continent IS NOT NULL
     GROUP BY [date]
     ORDER BY [date]

    -- Checking total population vs vaccination
    WITH  PopvsVac (cont, loc, crdate, pop, vac, RollingVacCount)
    AS
    (
    SELECT
        st.continent AS cont,
        st.[location] AS loc,
        st.[date] AS crdate,
        st.population as pop,
        vac.new_vaccinations as vac,
        SUM(vac.new_vaccinations) OVER (PARTITION BY st.[location] ORDER BY st.[location], st.[date]) AS RollingVacCount
     FROM covid_staging st
     JOIN covid_vaccination vac 
        ON st.[location] = vac.[location]
        AND st.[date] = vac.[date]
     WHERE st.continent IS NOT NULL
     )
     SELECT 
        *,
        (CAST(RollingVacCount AS FLOAT)/pop)*100
      FROM PopvsVac
      ORDER BY 2,3

-- Creating temp table for the data
    DROP TABLE IF EXISTS #PercentPopulationVaccinated
    CREATE TABLE #PercentPopulationVaccinated
    (
        continent NVARCHAR(255),
        location NVARCHAR(255),
        date DATE,
        population NUMERIC,
        new_vaccinations NUMERIC,
        RollingPeopleVaccinated NUMERIC
    );

    INSERT INTO #PercentPopulationVaccinated
     SELECT
        st.continent,
        st.[location],
        st.[date],
        st.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) OVER (PARTITION BY st.[location] ORDER BY st.[location], st.[date]) AS RollingVacCount
     FROM covid_staging st
     JOIN covid_vaccination vac 
        ON st.[location] = vac.[location]
        AND st.[date] = vac.[date]
        WHERE st.continent IS NOT NULL
      

    SELECT 
        *, 
        (RollingPeopleVaccinated/population)*100
     FROM #PercentPopulationVaccinated
     ORDER BY 2,3


