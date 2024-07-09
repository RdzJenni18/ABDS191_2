--Vista de especies y habitats
CREATE VIEW vw_especies_habitats
AS
SELECT s.id AS 'ID Especie', s.scientific_name AS 'Nombre Especie',
       a.common_name AS 'Nombre Animal', h.name AS 'Nombre habitat'
FROM species s
JOIN animals a ON s.animal_id = a.id
JOIN animals_habitats ah ON a.id = ah.animal_id
JOIN habitats h ON ah.habitat_id = h.id;
GO

--Vista de amenazas y especies
CREATE VIEW vw_amenazas_especies
AS
SELECT s.id AS 'ID Especie', s.scientific_name AS 'Nombre especie',
       t.name AS 'Amenaza', st.threat_id AS 'Tipo amenaza'
FROM species s
JOIN species_threats st ON s.id = st.specie_id
JOIN threats t ON st.threat_id = t.id;
GO
	

--Vista de asociaciones y especies
CREATE VIEW vw_asociaciones_especies
AS
SELECT s.id AS 'ID Especie', s.scientific_name AS 'Nombre especie',
       a.name AS 'Nombre asociacion', at.description AS 'Descripcion asociacion'
FROM species s
JOIN species_associations sa ON s.id = sa.specie_id
JOIN associations a ON sa.association_id = a.id
JOIN associations_types at ON a.association_type_id = at.id;
GO


--Procedimiento para insertar especies
CREATE PROCEDURE sp_insertar_especies
    @scientific_name VARCHAR(100),
    @description VARCHAR(MAX),
    @life_expectancy INT,
    @animal_id INT,
    @feeding_id INT,
    @conservation_status_id INT
AS
BEGIN
    INSERT INTO species (scientific_name, description, life_expectancy, animal_id, feeding_id, specie_conservation_status)
    VALUES (@scientific_name, @description, @life_expectancy, @animal_id, @feeding_id, @conservation_status_id);
END;
GO

EXEC sp_insertar_especies 
    'Panthera leo', 
    'El león es una especie de mamífero carnívoro de la familia de los félidos.',
	14,
    1,
    2,
    3;

	
--Procedimiento para actualizar especies
CREATE PROCEDURE sp_actualizar_especies
    @species_id INT,
    @scientific_name VARCHAR(100),
    @description VARCHAR(MAX),
    @life_expectancy INT,
    @feeding_id INT,
    @conservation_status_id INT
AS
BEGIN
    UPDATE species
    SET scientific_name = @scientific_name,
        description = @description,
        life_expectancy = @life_expectancy,
        feeding_id = @feeding_id,
        specie_conservation_status = @conservation_status_id
    WHERE id = @species_id;
END;
GO

EXEC sp_actualizar_especies 
    1, 
    'Panthera leo', 
    'El león es una especie de mamífero carnívoro de la familia de los félidos, conocido por su melena.',
    15,
    2,
    3;

	select * from species

--Procedimiento para obtener todas las especies en un habitat específico
CREATE PROCEDURE sp_especies_habitatEspecifico
    @habitat_id INT
AS
BEGIN
    SELECT s.id AS 'ID Especies', s.scientific_name AS 'Nombre especies'
    FROM species s
    JOIN animals a ON s.animal_id = a.id
    JOIN animals_habitats ah ON a.id = ah.animal_id
    WHERE ah.habitat_id = @habitat_id;
END;
GO

EXEC sp_especies_habitatEspecifico @habitat_id = 5;

--Procedimiento para eliminar especie por su ID
CREATE PROCEDURE sp_eliminar_especies
    @species_id INT
AS
BEGIN
    DELETE FROM species
    WHERE id = @species_id;
END;
GO

EXEC sp_eliminar_especies @species_id = 6;

select * from species

--Procedimiento para obtener información de una especie por su ID
CREATE PROCEDURE sp_InfoEspeciesID
    @species_id INT
AS
BEGIN
    SELECT *
    FROM species
    WHERE id = @species_id;
END;
GO

EXEC sp_InfoEspeciesID @species_id = 5;

--Procedimiento con transacción para insertar nueva medida de prevención 
CREATE PROCEDURE sp_InsertarMedidaPrevencion
    @name VARCHAR(100),
    @manager VARCHAR(100),
    @description VARCHAR(MAX),
    @start_date DATETIME,
    @end_date DATETIME,
    @economic_investment FLOAT,
    @measurement_type_id INT,
    @impact_assessment_id INT,
    @implementation_status_id INT,
    @association_id INT
AS
BEGIN
    BEGIN TRANSACTION;
	BEGIN TRY

    DECLARE @prevention_id INT;

    INSERT INTO prevention_measures (name, manager, description, start_date, end_date, economic_investment, measurement_type_id, impact_assessment_id, implementation_status_id)
    VALUES (@name, @manager, @description, @start_date, @end_date, @economic_investment, @measurement_type_id, @impact_assessment_id, @implementation_status_id);

    SET @prevention_id = SCOPE_IDENTITY();

    INSERT INTO associations_prevention_measures (association_id, prevention_measures_id)
    VALUES (@association_id, @prevention_id);

    COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

EXEC sp_InsertarMedidaPrevencion 
    'Reforestación',
    'John Doe',
    'Proyecto de reforestación para recuperar áreas deforestadas.',
    '2024-08-01',
    '2025-08-01',
    50000.00,
    1,
    2,
    3,
    4;

	select * from prevention_measures
	select * from associations_prevention_measures 

--Procedimiento con transaccion para actualizar el estado de implementación de una medida de prevención 
CREATE PROCEDURE sp_ActualizarEstatusPrevencion
    @prevention_id INT,
    @implementation_status_id INT
AS
BEGIN
    BEGIN TRANSACTION;
	BEGIN TRY

    UPDATE prevention_measures
    SET implementation_status_id = @implementation_status_id
    WHERE id = @prevention_id;

    COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

EXEC sp_ActualizarEstatusPrevencion 
    5, 
    3;

select * from prevention_measures

--Procedimiento para eliminar una asociación y sus medidas de prevención asociadas
CREATE PROCEDURE sp_eliminarAsociacionYMedidas
    @association_id INT
AS
BEGIN
    BEGIN TRANSACTION;
	BEGIN TRY

    DELETE FROM associations
    WHERE id = @association_id;

    DELETE FROM associations_prevention_measures
    WHERE association_id = @association_id;

    COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

EXEC sp_eliminarAsociacionYMedidas @association_id = 5;

Select * from associations