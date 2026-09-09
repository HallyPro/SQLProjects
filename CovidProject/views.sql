USE CovidProject
GO

  
------------------------------------------------------------------------ DeathCountPerContinent view --------------------------------------------------------------------------------------
IF OBJECT_ID('DeathCountPerContinent', 'V') IS NOT NULL
    DROP VIEW PercentPopulationVaccinated
GO

 -- Creating view for visualization
CREATE VIEW DeathCountPerContinent AS
    SELECT
        [location],
        MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
     FROM covid_staging
     WHERE continent IS NULL
     GROUP BY [location]
GO

  
------------------------------------------------------------------------ PercentPopulationVaccinated view --------------------------------------------------------------------------------------
IF OBJECT_ID('PercentPopulationVaccinated', 'V') IS NOT NULL
    DROP VIEW PercentPopulationVaccinated
GO
  
 -- Creating view for visualization
CREATE VIEW PercentPopulationVaccinated AS
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
GO


------------------------------------------------------------------------ InfectionRatePerCountry view --------------------------------------------------------------------------------------
IF OBJECT_ID('InfectionRatePerCountry', 'V') IS NOT NULL
    DROP VIEW InfectionRatePerCountry
GO

-- Creating View for visualization 
CREATE VIEW InfectionRatePerCountry AS
SELECT
    location,
    population,
    MAX(total_cases) AS highestInfetionCount,
    CAST( MAX(CAST(total_cases AS DECIMAL(18,0))/ population)*100 AS DECIMAL(10,2))AS Case_Pop_Pct
 FROM covid_staging
 WHERE continent IS NOT NULL
 GROUP BY location, population
