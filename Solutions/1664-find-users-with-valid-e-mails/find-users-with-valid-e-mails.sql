SELECT 
    user_id,      -- Selects the user's unique ID
    name,         -- Selects the user's name
    mail          -- Selects the user's email
FROM 
    users         -- From the 'users' table
WHERE 
    -- Ensures the email starts with a letter (a-z or A-Z), 
    -- followed by any combination of letters, digits, underscores, dots, or hyphens, 
    -- and ends with '@leetcode.com'
    mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$' 
    
    -- Ensures the match is case-sensitive for the domain part
    AND mail LIKE BINARY '%@leetcode.com';
