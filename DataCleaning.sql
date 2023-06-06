--Cleaning Daa in SQL Queries

select * from Portfolio..NashvileHousing

--Standerized Date Format

select SaleDate , CONVERT(Date,SaleDate) 
from Portfolio.dbo.NashvileHousing

update Portfolio..NashvileHousing
set SaleDate=CONVERT(Date,SaleDate)

Alter table NashvileHousing
add SaleDateConverted date;

-----------------------------------------------------------------------------------------
--Populate Property Data

select *
from Portfolio.dbo.NashvileHousing
--where PropertyAddress is null
order by ParcelID

select a.[UniqueID ],a.PropertyAddress,b.[UniqueID ],b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from Portfolio..NashvileHousing a
join Portfolio..NashvileHousing b
on a.ParcelID = b.ParcelID
And a.[UniqueID ]<>b.[UniqueID ]
--where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from Portfolio..NashvileHousing a
join Portfolio..NashvileHousing b
on a.ParcelID = b.ParcelID
And a.[UniqueID ]<>b.[UniqueID ]

----------------------------------------------------------------------------

--Breaking out Address into individual columns (Address,city,state)

--using Substring

select PropertyAddress
from Portfolio..NashvileHousing

select
substring(PropertyAddress ,1,charindex(',' , PropertyAddress) -1) as Address,
substring(PropertyAddress ,charindex(',' , PropertyAddress) +1,len(PropertyAddress)) as Address
from Portfolio..NashvileHousing

Alter table NashvileHousing
add PropertySplitAddress Nvarchar(255);

update NashvileHousing
set PropertySplitAddress=substring(PropertyAddress ,1,charindex(',' , PropertyAddress) -1)


Alter table NashvileHousing
add PropertySplitCity Nvarchar(255);

update NashvileHousing
set PropertySplitCity=substring(PropertyAddress ,charindex(',' , PropertyAddress) +1,len(PropertyAddress))

select *
from Portfolio..NashvileHousing


--Using ParseName

select OwnerAddress
from Portfolio..NashvileHousing

select 
PARSENAME(replace(OwnerAddress,',','.'),3)
,PARSENAME(replace(OwnerAddress,',','.'),2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
from Portfolio..NashvileHousing

Alter table Portfolio.. NashvileHousing
add OwnerSplitAddress Nvarchar(255);
update Portfolio.. NashvileHousing
set OwnerSplitAddress=PARSENAME(replace(OwnerAddress,',','.'),3)

Alter table Portfolio.. NashvileHousing
add OwnerSplitCity Nvarchar(255);
update Portfolio.. NashvileHousing
set OwnerSplitCity=PARSENAME(replace(OwnerAddress,',','.'),2)

Alter table Portfolio.. NashvileHousing
add OwnerSplitState Nvarchar(255);
update Portfolio.. NashvileHousing
set OwnerSplitState=PARSENAME(replace(OwnerAddress,',','.'),1)

------------------------------------------------------------------------------------
--Change N and Y to No and Yes in SoldAsVacant column

select Distinct(SoldAsVacant)
from Portfolio..NashvileHousing

select SoldAsVacant
,Case when SoldAsVacant='N' then 'No'
	  when SoldAsVacant='Y' then 'Yes'
	  else SoldAsVacant
	  end
from Portfolio..NashvileHousing

update Portfolio..NashvileHousing
set SoldAsVacant=Case when SoldAsVacant='N' then 'No'
	  when SoldAsVacant='Y' then 'Yes'
	  else SoldAsVacant
	  end
from Portfolio..NashvileHousing

-------------------------------------------------------------



