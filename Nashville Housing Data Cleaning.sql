-- Cleaning Data in SQL Queries.

SELECT * FROM PortfolioProject..NashvilleHousing;

-- Standardize Date Format.
SELECT SaleDate, CONVERT(Date,SaleDate)
FROM PortfolioProject..NashvilleHousing;

UPDATE PortfolioProject..NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate);

-- Creating a new column to replace an existing one with the same data.
ALTER TABLE PortfolioProject..NashvilleHousing
Add SaleDateConverted Date;

SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM PortfolioProject..NashvilleHousing;

UPDATE PortfolioProject..NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate);

-- Populate Property Address Data.
SELECT * FROM PortfolioProject..NashvilleHousing
WHERE PropertyAddress IS NULL
ORDER BY ParcelID;

SELECT emptyAdd.ParcelID, emptyAdd.PropertyAddress, fullAdd.ParcelID, fullAdd.PropertyAddress,
	ISNULL(emptyAdd.PropertyAddress,fullAdd.PropertyAddress)
FROM PortfolioProject..NashvilleHousing emptyAdd
JOIN PortfolioProject..NashvilleHousing fullAdd
	ON emptyAdd.ParcelID = fullAdd.ParcelID
	AND emptyAdd.[UniqueID ] <> fullAdd.[UniqueID ]
WHERE emptyAdd.PropertyAddress IS NULL;

UPDATE emptyAdd
SET PropertyAddress = ISNULL(emptyAdd.PropertyAddress,fullAdd.PropertyAddress)
FROM PortfolioProject..NashvilleHousing emptyAdd
JOIN PortfolioProject..NashvilleHousing fullAdd
	ON emptyAdd.ParcelID = fullAdd.ParcelID
	AND emptyAdd.[UniqueID ] <> fullAdd.[UniqueID ]
WHERE emptyAdd.PropertyAddress IS NULL;

-- Breaking out Address into Individual Columns (Address and City).
SELECT PropertyAddress
FROM PortfolioProject..NashvilleHousing;

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM PortfolioProject..NashvilleHousing;

ALTER TABLE PortfolioProject..NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

UPDATE PortfolioProject..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1);

ALTER TABLE PortfolioProject..NashvilleHousing
Add PropertySplitCity Nvarchar(255);

UPDATE PortfolioProject..NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress));

SELECT * FROM PortfolioProject..NashvilleHousing;

-- Breaking out Address into Individual Columns (Address, City and State).
SELECT OwnerAddress
FROM PortfolioProject..NashvilleHousing;

SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM PortfolioProject..NashvilleHousing;

ALTER TABLE PortfolioProject..NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3);

ALTER TABLE PortfolioProject..NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2);

ALTER TABLE PortfolioProject..NashvilleHousing
Add OwnerSplitState Nvarchar(255);

UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1);

SELECT * FROM PortfolioProject..NashvilleHousing;

-- Change Y and N to Yes and No in the SoldAsVacant field.
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant, CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM PortfolioProject..NashvilleHousing;

UPDATE PortfolioProject..NashvilleHousing
SET SoldAsVacant = CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END;

-- Remove Duplicates.
SELECT * FROM PortfolioProject..NashvilleHousing;

WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	ORDER BY UniqueID
	) AS Row_Num
FROM PortfolioProject..NashvilleHousing
--ORDER BY ParcelID
)
SELECT * FROM RowNumCTE
WHERE Row_Num > 1
ORDER BY PropertyAddress;

WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	ORDER BY UniqueID
	) AS Row_Num
FROM PortfolioProject..NashvilleHousing
--ORDER BY ParcelID
)
DELETE FROM RowNumCTE
WHERE Row_Num > 1;

-- Delete Unused Columns.
SELECT * FROM PortfolioProject..NashvilleHousing;

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress;

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN SaleDate;
