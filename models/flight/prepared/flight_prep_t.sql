WITH flight_prep_t AS (
   SELECT year, 
        month,
        TRY_CAST(dayOfMonth AS INT) AS dayOfMonth,
        TRY_CAST(dayOfWeek AS INT) AS dayOfWeek,
        TRY_CAST(depTime AS INT) AS depTime,
        TRY_CAST(crsDepTime AS INT) AS crsDepTime,
        TRY_CAST(arrTime AS INT) AS arrTime,
        TRY_CAST(crsArrTime AS INT) AS crsArrTime,
        uniqueCarrier,
        flightNum,
        tailNum,
        TRY_CAST(actualElapsedTime AS INT) AS actualElapsedTime,
        TRY_CAST(crsElapsedTime AS INT) AS crsElapsedTime,
        TRY_CAST(airTime AS INT) AS airTime,
        TRY_CAST(arrDelay AS INT) AS arrDelay,
        TRY_CAST(depDelay AS INT) AS depDelay,
        origin,
        destination,
        TRY_CAST(distance AS INT) AS distance,
        TRY_CAST(taxiIn AS INT) AS taxiIn,
        TRY_CAST(taxiOut AS INT) AS taxiOut, 
        CASE WHEN cancelled IS NULL 
                THEN 0 
            WHEN cancelled = 'N' 
                THEN 0
            ELSE 1 
        END AS cancelled,         
        CASE WHEN cancellationCode IS NULL 
                THEN 0 
            WHEN cancellationCode = 'N' 
                THEN 0
            ELSE 1 
        END AS cancellationCode,         
        CASE WHEN diverted IS NULL 
                THEN 0 
            WHEN diverted = 'N' 
                THEN 0
            ELSE 1 
        END AS diverted,         
        CASE WHEN carrierDelay IS NULL
                THEN NULL 
            WHEN carrierDelay = 'NA' 
                THEN NULL
            ELSE CAST(carrierDelay AS INT)
        END AS carrierDelay,
        CASE WHEN weatherDelay IS NULL
                THEN NULL 
            WHEN weatherDelay = 'NA' 
                THEN NULL
            ELSE CAST(weatherDelay AS INT)
        END AS weatherDelay,
        CASE WHEN nasDelay IS NULL
                THEN NULL 
            WHEN nasDelay = 'NA' 
                THEN NULL
            ELSE CAST(nasDelay AS INT)
        END AS nasDelay,
        CASE WHEN securityDelay IS NULL
                THEN NULL 
            WHEN securityDelay = 'NA' 
                THEN NULL
            ELSE CAST(securityDelay AS INT)
        END AS securityDelay,
        CASE WHEN lateAircraftDelay IS NULL
                THEN NULL 
            WHEN lateAircraftDelay = 'NA' 
                THEN NULL
            ELSE CAST(lateAircraftDelay AS INT)
        END AS lateAircraftDelay
    from {{ source('flight_db', 'flight_raw_t') }} 
)select * 
from flight_prep_t

