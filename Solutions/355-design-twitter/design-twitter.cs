using System;
using System.Collections.Generic;
using System.Linq;

public class Twitter {

    // Keep track of each user's tweets
    private Dictionary<int, List<(int tweetId, int time)>> userTweets;
    
    // Keep track of each user's followings
    private Dictionary<int, HashSet<int>> userFollows;
    
    // Global timestamp to order tweets
    private int timestamp;

    /** Initialize your data structure here. */
    public Twitter() {
        userTweets = new Dictionary<int, List<(int tweetId, int time)>>();
        userFollows = new Dictionary<int, HashSet<int>>();
        timestamp = 0;
    }
    
    /** Compose a new tweet. */
    public void PostTweet(int userId, int tweetId) {
        if (!userTweets.ContainsKey(userId)) {
            userTweets[userId] = new List<(int, int)>();
        }
        userTweets[userId].Add((tweetId, timestamp++));
    }
    
    /** Retrieve the 10 most recent tweet IDs in the user's news feed. */
    public IList<int> GetNewsFeed(int userId) {
        List<(int tweetId, int time)> tweetsToConsider = new List<(int, int)>();
        
        // Add user's own tweets
        if (userTweets.ContainsKey(userId))
            tweetsToConsider.AddRange(userTweets[userId]);
        
        // Add tweets from people user follows
        if (userFollows.ContainsKey(userId)) {
            foreach (int followeeId in userFollows[userId]) {
                if (userTweets.ContainsKey(followeeId))
                    tweetsToConsider.AddRange(userTweets[followeeId]);
            }
        }
        
        // Order tweets by timestamp descending and take top 10
        return tweetsToConsider
            .OrderByDescending(t => t.time)
            .Take(10)
            .Select(t => t.tweetId)
            .ToList();
    }
    
    /** Follower follows a followee. */
    public void Follow(int followerId, int followeeId) {
        if (followerId == followeeId) return; // cannot follow self
        if (!userFollows.ContainsKey(followerId))
            userFollows[followerId] = new HashSet<int>();
        userFollows[followerId].Add(followeeId);
    }
    
    /** Follower unfollows a followee. */
    public void Unfollow(int followerId, int followeeId) {
        if (userFollows.ContainsKey(followerId))
            userFollows[followerId].Remove(followeeId);
    }
}

/**
 * Example Usage:
 * Twitter twitter = new Twitter();
 * twitter.PostTweet(1, 5);
 * var feed1 = twitter.GetNewsFeed(1); // returns [5]
 * twitter.Follow(1, 2);
 * twitter.PostTweet(2, 6);
 * var feed2 = twitter.GetNewsFeed(1); // returns [6, 5]
 * twitter.Unfollow(1, 2);
 * var feed3 = twitter.GetNewsFeed(1); // returns [5]
 */
