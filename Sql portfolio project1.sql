-- cleaning data:

Select *
From [portfolio project].dbo.[Nashville Housing ] 


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Populate property address data:

Select *
From [portfolio project].dbo.[Nashville Housing ]
-- Where PropertyAddress IS NULL
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From [portfolio project].dbo.[Nashville Housing ] a
Join [portfolio project].dbo.[Nashville Housing ] b
   On a.ParcelID = b.ParcelID
   AND a.UniqueID <> b.UniqueID
Where a.PropertyAddress IS NULL



UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From [portfolio project].dbo.[Nashville Housing ] a
Join [portfolio project].dbo.[Nashville Housing ] b
   On a.ParcelID = b.ParcelID
   AND a.UniqueID <> b.UniqueID
Where a.PropertyAddress IS NULL



-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-------------------Breaking Out  Propert Address Into(Address, City);--------------------------------------------------------------------------------------

Select PropertyAddress
From [portfolio project].dbo.[Nashville Housing ]

Select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)) AS Address
From  [portfolio project].dbo.[Nashville Housing ]

-- For removing ',' from end of address just insert '-1' ;

Select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) AS Address
From  [portfolio project].dbo.[Nashville Housing ]


Select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1 , LEN (PropertyAddress))AS Address

From  [portfolio project].dbo.[Nashville Housing ]



ALTER TABLE [Nashville Housing]
ADD PropertySplitAddress NVARCHAR(255)

UPDATE  [Nashville Housing ]
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)



ALTER TABLE [Nashville Housing]
ADD PropertySplitCity NVARCHAR(255)


UPDATE  [Nashville Housing ]
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1 , LEN (PropertyAddress))


Select *
From [portfolio project].dbo.[Nashville Housing ]

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------Breaking Out Owner Address Into (Address, City, State)--------------------------------------------------------------------------------------

SELECT OwnerAddress
From [portfolio project].dbo.[Nashville Housing ]


Select PARSENAME(REPLACE(OwnerAddress,',','.'),3) AS Address,
 PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS City,
  PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS State

From [portfolio project].dbo.[Nashville Housing ]



ALTER TABLE [Nashville Housing]
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE [Nashville Housing ]
SET OwnerSplitAddress =PARSENAME(REPLACE(OwnerAddress,',','.'),3 )



ALTER TABLE [Nashville Housing]
ADD OwnerSplitCity NVARCHAR(255)

UPDATE [Nashville Housing ]
SET OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress,',','.'),2 )



ALTER TABLE [Nashville Housing]
ADD OwnerSplitState NVARCHAR(255)

UPDATE [Nashville Housing ]
SET OwnerSplitState =PARSENAME(REPLACE(OwnerAddress,',','.'),1 )

Select *
From [portfolio project].dbo.[Nashville Housing ]








