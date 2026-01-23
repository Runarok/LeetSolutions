-- Select the tweet_id column
SELECT tweet_id  
-- From the Tweets table
FROM Tweets  
-- Where the length of the content is greater than 15 characters
WHERE LENGTH(content) > 15;  
-- Explanation per line:
-- SELECT tweet_id      -> choose only the tweet_id column to display
-- FROM Tweets          -> from the Tweets table
-- WHERE LENGTH(content) > 15
--   -> LENGTH(content) gives the number of characters in 'content'
--   -> Only include rows where the content has more than 15 characters
-- Result: Only tweets with content longer than 15 characters are returned
