use Instagram;

### Join Queries

#### Query 1: Get posts along with user details, hashtags, and tags.
SELECT 
    p.POST_ID, 
    u.USER_NAME, 
    p.CONTENT, 
    h.HASHTAG_TEXT, 
    t.TAG_NAME
FROM 
    POST p
JOIN 
    USER u ON p.USER_ID = u.USER_ID
JOIN 
    POST_HASHTAG ph ON p.POST_ID = ph.POST_ID
JOIN 
    HASHTAG h ON ph.HASHTAG_ID = h.HASHTAG_ID
JOIN 
    POST_TAG pt ON p.POST_ID = pt.POST_ID
JOIN 
    TAG t ON pt.TAG_ID = t.TAG_ID;
    
    
#### Query 2: Get stories along with user details, live event details, and reactions.
SELECT 
    s.STORY_ID, 
    u.USER_NAME, 
    s.CONTENT, 
    le.EVENT_NAME, 
    r.REACTIONTYPE
FROM 
    STORY s
JOIN 
    USER u ON s.USER_ID = u.USER_ID
JOIN 
    LIVE_EVENT le ON s.EVENT_ID = le.EVENT_ID
JOIN 
    STORY_REACTION sr ON s.STORY_ID = sr.STORY_ID
JOIN 
    REACTIONS r ON sr.REACTION_ID = r.REACTION_ID;
    
    
#### Query 3: Get users along with the groups they belong to, their followers, and notifications.
SELECT 
    u.USER_NAME,
    g.GROUP_NAME,
    f.FOLLOWER_ID,
    n.TIMESTAMP AS NOTIFICATION_TIMESTAMP
FROM 
    USER u
JOIN 
    GROUPP g ON u.USER_ID = g.USER_ID
JOIN 
    FOLLOWER f ON u.USER_ID = f.USER_ID
JOIN 
    NOTIFICATIONS n ON u.USER_ID = n.USER_ID;
    
    
#### Query 4: Get ads along with performance metrics, region details, and related posts.
SELECT 
    a.AD_CONTENT,
    apm.REGION,
    apm.INTERACTIONS,
    p.CONTENT AS POST_CONTENT
FROM 
    ADS a
JOIN 
    AdPerformanceMetrics apm ON a.AD_ID = apm.AD_ID
JOIN 
    POST p ON a.AD_ID = p.AD_ID;
    
    
#### Query 5: Get polls along with messages sent by users, message timestamps, and poll questions.
SELECT 
    m.MESSAGE_ID,
    u.USER_NAME,
    m.TIMESTAMP AS MESSAGE_TIMESTAMP,
    po.QUESTIONS
FROM 
    MESSAGE m
JOIN 
    SENDS s ON m.MESSAGE_ID = s.MESSAGE_ID
JOIN 
    USER u ON s.USER_ID = u.USER_ID
JOIN 
    POLL po ON m.POLL_ID = po.POLL_ID;
    
    
#### Query 6: Get comments along with post details, user details, and archive timestamps.
SELECT 
    c.COMMENT_ID,
    p.CONTENT AS POST_CONTENT,
    u.USER_NAME,
    a.TIMESTAMP AS ARCHIVE_TIMESTAMP
FROM 
    COMMENT c
JOIN 
    POST p ON c.POST_ID = p.POST_ID
JOIN 
    USER u ON p.USER_ID = u.USER_ID
JOIN 
    ARCHIVE a ON p.ARCHIVE_ID = a.ARCHIVE_ID;
    
    
#### Query 7: Get live events along with interaction responses, user details, and story contents.
SELECT 
    le.EVENT_NAME,
    lei.RESPONSE,
    u.USER_NAME,
    s.CONTENT AS STORY_CONTENT
FROM 
    LIVE_EVENT le
JOIN 
    Live_EventInteraction lei ON le.EVENT_ID = lei.EVENT_ID
JOIN 
    STORY s ON le.EVENT_ID = s.EVENT_ID
JOIN 
    USER u ON s.USER_ID = u.USER_ID;


#### Query 8: Get reports along with post details, user details, and reasons for reporting.
SELECT 
    r.REPORT_ID,
    p.CONTENT AS POST_CONTENT,
    u.USER_NAME,
    r.REASON
FROM 
    REPORT r
JOIN 
    POST p ON r.POST_ID = p.POST_ID
JOIN 
    USER u ON p.USER_ID = u.USER_ID;
    
    
#### Query 9: Get likes along with post details, user details, and like timestamps.
SELECT 
    l.LIKE_ID,
    p.CONTENT AS POST_CONTENT,
    u.USER_NAME,
    p.TIMESTAMP AS LIKE_TIMESTAMP
FROM 
    LIKES l
JOIN 
    POST p ON l.POST_ID = p.POST_ID
JOIN 
    LIKES_POST lp ON l.LIKE_ID = lp.LIKE_ID
JOIN 
    USER u ON lp.USER_ID = u.USER_ID;


#### Query 10: Get notifications along with user details, notification types, and timestamps.
SELECT 
    n.NOTIFICATION_ID,
    u.USER_NAME,
    nnt.NOTIFICATION_TYPE,
    n.TIMESTAMP
FROM 
    NOTIFICATIONS n
JOIN 
    USER u ON n.USER_ID = u.USER_ID
JOIN 
    NOTIFICATIONS_NOTIFICATION_TYPE nnt ON n.NOTIFICATION_ID = nnt.NOTIFICATION_ID;


#### Query 11: Get archives along with post details, user details, and ad content.
SELECT 
    a.ARCHIVE_ID,
    p.CONTENT AS POST_CONTENT,
    u.USER_NAME,
    ad.AD_CONTENT
FROM 
    ARCHIVE a
JOIN 
    POST p ON a.ARCHIVE_ID = p.ARCHIVE_ID
JOIN 
    USER u ON p.USER_ID = u.USER_ID
JOIN 
    ADS ad ON p.AD_ID = ad.AD_ID;


#### Query 12: Get tags along with post details, user details, and group names.
SELECT 
    t.TAG_NAME,
    p.CONTENT AS POST_CONTENT,
    u.USER_NAME,
    g.GROUP_NAME
FROM 
    TAG t
JOIN 
    POST_TAG pt ON t.TAG_ID = pt.TAG_ID
JOIN 
    POST p ON pt.POST_ID = p.POST_ID
JOIN 
    USER u ON p.USER_ID = u.USER_ID
JOIN 
    GROUPP g ON u.USER_ID = g.USER_ID;


### Correlated Subqueries

-- 1. Find the top 5 users who have the most liked posts.

-- This helps identify popular creators on the platform.

Select u.USER_NAME from user u where exists (
Select p.USER_ID from post p where u.USER_ID=p.USER_ID And exists (
Select l.POST_ID from likes l where p.POST_ID=l.POST_ID And exists (
select lp.LIKE_ID from likes_post lp where l.LIKE_ID=lp.LIKE_ID group by USER_ID order by count(lp.LIKE_ID) desc )))limit 5;

-- 2. Find the details of users who created posts using a specific ad and also have an active story in a live event

-- This is useful for tracking the engagement of ad-driven content creators.
Select u.USER_NAME from user u where exists (
Select p.USER_ID from post p where u.USER_ID=p.USER_ID AND exists (
select a.AD_ID from ads a where p.AD_ID=a.AD_ID AND a.AD_CONTENT='Fashion Brands'))
And  exists(
Select s.USER_ID from story s where u.USER_ID=s.USER_ID AND exists (
Select e.EVENT_ID from live_event e where s.EVENT_ID=e.EVENT_ID));

-- 3.Get the list of notifications sent to users who reacted to a story in a specific live event.

-- This is helpful for tracking user engagement in events and notifications(for specific exmaple we chose fashion week ).
select * from notifications n where exists(
select u.USER_ID from user u where n.USER_ID=u.USER_ID AND exists (
select s.USER_ID from story s where u.USER_ID=s.USER_ID And exists
(select e.EVENT_ID from live_event e where S.EVENT_ID=e.EVENT_ID And e.EVENT_NAME='Fashion Week') and exists (
select sr.STORY_ID from story_reaction sr where s.STORY_ID=sr.STORY_ID )));
 
-- 4.List the users who have liked posts with specific hashtags.

-- This provides insights into user preferences and engagement with hashtag-based content (for specfic we chose music as example).
Select u.USER_NAME from user u where exists (
Select lp.USER_ID from likes_post lp where u.USER_ID =lp.USER_ID And exists  (
Select l.LIKE_ID from likes l where lp.LIKE_ID=l.LIKE_ID  AND exists (
Select p.POST_ID from post p where l.POST_ID=p.POST_ID AND exists (
Select ph.POST_ID from post_hashtag ph where p.POST_ID= ph.POST_ID And exists (
select h.HASHTAG_ID from hashtag h where ph.HASHTAG_ID= h.HASHTAG_ID And HASHTAG_TEXT='#music')))));

-- 5. Retrieve all hashtags associated with posts that were reported for a specific reason

-- This is useful for analyzing controversial or problematic content tied to specific hashtags (for specific reason we chose harassment as example).
select h.*from hashtag h where  exists(
select ph.HASHTAG_ID from post_hashtag ph where  h.HASHTAG_ID=ph.HASHTAG_ID AND exists(
Select p.POST_ID from post p where  ph.POST_ID=p.POST_ID AND exists (
Select r.POST_ID from report r where p.POST_ID=r.POST_ID And r.REASON='Harassment'))); 
### SUBQUERIES QUERIES

### QUERY 1. Find the top 5 users who have the most liked posts.

Select u.USER_NAME from user u where u.USER_ID in (
Select p.USER_ID from post p where p.USER_ID  in (
Select l.POST_ID from likes l where l.LIKE_ID in (
select lp.LIKE_ID from likes_post lp group by USER_ID order by count(lp.LIKE_ID) desc )))limit 5;

### QUERY 2. Find the details of users who created posts using a specific ad and also have an active story in a live event

Select u.USER_NAME from user u where u.USER_ID in (
Select p.USER_ID from post p where p.AD_ID  in (
select a.AD_ID from ads a where a.AD_CONTENT='Fashion Brands'))
And  u.USER_ID in(
Select u.USER_ID from user u where u.USER_ID in (
Select s.USER_ID from story s where s.EVENT_ID in (
Select e.EVENT_ID from live_event e)));

### QUERY 3. Get the list of notifications sent to users who reacted to a story in a specific live event.

select * from notifications n where n.USER_ID in(
select u.USER_ID from user u where u.USER_ID in(
select s.USER_ID from story s where s.EVENT_ID in 
(select e.EVENT_ID from live_event e where e.EVENT_NAME='Fashion Week') and s.STORY_ID in (
select sr.STORY_ID from story_reaction sr)));
 
### QUERY 4. List the users who have liked posts with specific hashtags.

Select u.USER_NAME from user u where u.USER_ID in (
Select lp.USER_ID from likes_post lp where lp.LIKE_ID in (
Select l.LIKE_ID from likes l where l.POST_ID in (
Select p.POST_ID from post p where p.POST_ID in (
Select ph.POST_ID from post_hashtag ph where ph.HASHTAG_ID in(
select h.HASHTAG_ID from hashtag h where HASHTAG_TEXT='#music')))));

### QUERY 5. Retrieve all hashtags associated with posts that were reported for a specific reason

select h.*from hashtag h where h.HASHTAG_ID in(
select ph.HASHTAG_ID from post_hashtag ph where ph.POST_ID in(
Select p.POST_ID from post p where p.POST_ID in (
Select r.POST_ID from report r where r.REASON='Harassment'))); 


