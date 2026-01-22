SELECT 
    ip,
    COUNT(*) AS invalid_count
FROM logs
WHERE
    -- check if IP has exactly 4 octets
    (LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) <> 3)
    OR
    -- check for any octet > 255
    ip REGEXP '(^|\\.)((25[6-9]|2[6-9][0-9]|[3-9][0-9]{2,})|[0-9]{4,})(\\.|$)'
    OR
    -- check for leading zeros in any octet
    ip REGEXP '(^|\\.)0[0-9]+(\\.|$)'
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;
