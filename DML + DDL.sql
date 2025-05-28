create database Instagram;
use Instagram;

CREATE TABLE USER
(
  USER_ID INT NOT NULL,
  USER_NAME varchar(50) NOT NULL,
  EMAIL varchar(50) NOT NULL,
  PASSWORD varchar(50) NOT NULL,
  FIRST_NAME varchar(50),
  LAST_NAME varchar(50) ,
  PROFILE_PICTURE varchar(50),
  BIO varchar(50),
  DATE_of_BIRTH DATE,
  ACCOUNTED_CREATED DATE NOT NULL,
  STATUS varchar(50) NOT NULL,
  FOLLOWERS_COUNT INT ,
  PRIMARY KEY (USER_ID)
);

CREATE TABLE HASHTAG
(
  HASHTAG_ID INT NOT NULL,
  HASHTAG_TEXT varchar(50) ,
  PRIMARY KEY (HASHTAG_ID)
);

CREATE TABLE FOLLOWER
(
  FOLLOWER_ID INT NOT NULL,
  USER_ID INT,
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);

CREATE TABLE TAG
(
  TAG_ID INT NOT NULL,
  TAG_NAME varchar(50) ,
  PRIMARY KEY (TAG_ID)
);

CREATE TABLE GROUPP
(
  GROUP_ID INT NOT NULL,
  GROUP_NAME varchar(50),
  DESCRIPTION varchar(50),
  CREATION_DATE DATE NOT NULL,
  STATUS varchar(50) NOT NULL,
  USER_ID INT,
  PRIMARY KEY (GROUP_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);

CREATE TABLE LIVE_EVENT
(
  EVENT_ID INT NOT NULL,
  EVENT_NAME varchar(50),
  TIMESTAMP DATE NOT NULL,
  PRIMARY KEY (EVENT_ID)
);

CREATE TABLE ADS
(
  AD_ID INT NOT NULL,
  AD_CONTENT varchar(50) NOT NULL,
  STARTDATE DATE NOT NULL,
  ENDDATE DATE NOT NULL,
  PRIMARY KEY (AD_ID)
);

CREATE TABLE REACTIONS
(
  REACTION_ID INT NOT NULL,
  REACTIONTYPE varchar(50) NOT NULL,
  PRIMARY KEY (REACTION_ID)
);

CREATE TABLE NOTIFICATIONS
(
  NOTIFICATION_ID INT NOT NULL,
  TIMESTAMP timestamp NULL,
  USER_ID INT,
  PRIMARY KEY (NOTIFICATION_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);

CREATE TABLE POLL
(
  POLL_ID INT NOT NULL,
  QUESTIONS varchar(250),
  PRIMARY KEY (POLL_ID)
);

CREATE TABLE ARCHIVE
(
  ARCHIVE_ID INT NOT NULL,
  TIMESTAMP timestamp NOT NULL,
  PRIMARY KEY (ARCHIVE_ID)
);

CREATE TABLE AdPerformanceMetrics
(
  METRIC_ID INT NOT NULL,
  REGION varchar(50) NOT NULL,
  INTERACTIONS varchar(50),
  AD_ID INT NOT NULL,
  PRIMARY KEY (METRIC_ID),
  FOREIGN KEY (AD_ID) REFERENCES ADS(AD_ID)
);

CREATE TABLE Live_EventInteraction
(
  INTERACTION_ID INT NOT NULL,
  RESPONSE VARCHAR(50),
  EVENT_ID INT NOT NULL,
  PRIMARY KEY (INTERACTION_ID),
  FOREIGN KEY (EVENT_ID) REFERENCES LIVE_EVENT(EVENT_ID)
);

CREATE TABLE NOTIFICATIONS_NOTIFICATION_TYPE
(
  NOTIFICATION_TYPE INT NOT NULL,
  NOTIFICATION_ID INT NOT NULL,
  PRIMARY KEY (NOTIFICATION_TYPE, NOTIFICATION_ID),
  FOREIGN KEY (NOTIFICATION_ID) REFERENCES NOTIFICATIONS(NOTIFICATION_ID)
);

CREATE TABLE POST
(
  POST_ID INT NOT NULL,
  CONTENT varchar(50),
  CAPTION varchar(50) ,
  TIMESTAMP timestamp NOT NULL,
  LIKES_COUNT INT,
  COMMENTS_COUNT INT,
  USER_ID INT,
  AD_ID INT NOT NULL,
  ARCHIVE_ID INT NOT NULL,
  PRIMARY KEY (POST_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
  FOREIGN KEY (AD_ID) REFERENCES ADS(AD_ID),
  FOREIGN KEY (ARCHIVE_ID) REFERENCES ARCHIVE(ARCHIVE_ID)
);

CREATE TABLE COMMENT
(
  COMMENT_ID INT NOT NULL,
  TEXT varchar(50) ,
  TIMESTAMP timestamp NOT NULL,
  POST_ID INT,
  PRIMARY KEY (COMMENT_ID),
  FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID)
);

CREATE TABLE LIKES
(
  LIKE_ID INT NOT NULL,
  POST_ID INT,
  PRIMARY KEY (LIKE_ID),
  FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID)
);

CREATE TABLE STORY
(
  STORY_ID INT NOT NULL,
  CONTENT varchar(50),
  TIMESTAMP timestamp,
  USER_ID INT,
  EVENT_ID INT NOT NULL,
  PRIMARY KEY (STORY_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
  FOREIGN KEY (EVENT_ID) REFERENCES LIVE_EVENT(EVENT_ID)
);

CREATE TABLE MESSAGE
(
  MESSAGE_ID INT NOT NULL,
  CONTENT varchar(50) ,
  TIMESTAMP timestamp,
  POLL_ID INT NOT NULL,
  PRIMARY KEY (MESSAGE_ID),
  FOREIGN KEY (POLL_ID) REFERENCES POLL(POLL_ID)
);

CREATE TABLE POST_HASHTAG
(
  POST_ID INT,
  HASHTAG_ID INT NOT NULL,
  FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID),
  FOREIGN KEY (HASHTAG_ID) REFERENCES HASHTAG(HASHTAG_ID)
);

CREATE TABLE REPORT
(
  REPORT_ID INT NOT NULL,
  POST_ID INT NOT NULL,
  TIMESTAMP timestamp,
  REASON varchar(50),
  PRIMARY KEY (REPORT_ID),
  FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID)
);

CREATE TABLE LIKES_POST
(
  USER_ID INT,
  LIKE_ID INT,
  PRIMARY KEY (USER_ID, LIKE_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
  FOREIGN KEY (LIKE_ID) REFERENCES LIKES(LIKE_ID)
);

CREATE TABLE COMMENTS
(
  USER_ID INT NOT NULL,
  COMMENT_ID INT NOT NULL,
  PRIMARY KEY (USER_ID, COMMENT_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
  FOREIGN KEY (COMMENT_ID) REFERENCES COMMENT(COMMENT_ID)
);

CREATE TABLE SENDS
(
  USER_ID INT NOT NULL,
  MESSAGE_ID INT NOT NULL,
  PRIMARY KEY (USER_ID, MESSAGE_ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
  FOREIGN KEY (MESSAGE_ID) REFERENCES MESSAGE(MESSAGE_ID)
);

CREATE TABLE POST_TAG
(
  POST_ID INT NOT NULL,
  TAG_ID INT NOT NULL,
  PRIMARY KEY (POST_ID, TAG_ID),
  FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID),
  FOREIGN KEY (TAG_ID) REFERENCES TAG(TAG_ID)
);

CREATE TABLE STORY_REACTION
(
  STORY_ID INT NOT NULL,
  REACTION_ID INT NOT NULL,
  PRIMARY KEY (STORY_ID, REACTION_ID),
  FOREIGN KEY (STORY_ID) REFERENCES STORY(STORY_ID),
  FOREIGN KEY (REACTION_ID) REFERENCES REACTIONS(REACTION_ID)
);

#DATA INSERTION

use Instagram;

-- USER Table#]
INSERT INTO USER (USER_ID, USER_NAME, EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, PROFILE_PICTURE, BIO, DATE_of_BIRTH, ACCOUNTED_CREATED, STATUS, FOLLOWERS_COUNT) VALUES
(1, 'johndoe', 'john@example.com', 'password123', 'John', 'Doe', 'profile1.jpg', 'Love to code', '1990-01-15', '2023-01-01', 'Active', 100),
(2, 'janedoe', 'jane@example.com', 'password456', 'Jane', 'Doe', 'profile2.jpg', 'Artist', '1992-02-25', '2023-01-05', 'Active', 200),
(3, 'admin', 'admin@example.com', 'admin123', 'Admin', NULL, 'admin.jpg', 'Administrator', '1988-05-12', '2023-01-10', 'Active', 500),
(4, 'alexsmith', 'alex@example.com', 'alexpass', 'Alex', 'Smith', 'profile4.jpg', 'Photographer', '1995-04-10', '2023-02-01', 'Active', 250),
(5, 'maryjane', 'mary@example.com', 'marypass', 'Mary', 'Jane', 'profile5.jpg', 'Food blogger', '1991-08-20', '2023-02-10', 'Active', 300),
(6, 'lucygray', 'lucy@example.com', 'lucypass', 'Lucy', 'Gray', 'profile6.jpg', 'Traveler', '1989-03-30', '2023-03-01', 'Active', 400),
(7, 'michaelk', 'michael@example.com', 'mike123', 'Michael', 'King', 'profile7.jpg', 'Fitness freak', '1987-06-25', '2023-03-15', 'Active', 350),
(8, 'peterpan', 'peter@example.com', 'panpass', 'Peter', 'Pan', 'profile8.jpg', 'Musician', '1993-11-11', '2023-04-01', 'Active', 150),
(9, 'chrisreeve', 'chris@example.com', 'chrispass', 'Chris', 'Reeve', 'profile9.jpg', 'Entrepreneur', '1990-12-15', '2023-04-20', 'Active', 100),
(10, 'natashar', 'natasha@example.com', 'natpass', 'Natasha', 'Roman', 'profile10.jpg', 'Fashionista', '1994-07-05', '2023-05-01', 'Active', 180);

-- HASHTAG Table
INSERT INTO HASHTAG (HASHTAG_ID, HASHTAG_TEXT) VALUES
(1, '#coding'),
(2, '#nature'),
(3, '#art'),
(4, '#photography'),
(5, '#travel'),
(6, '#fitness'),
(7, '#music'),
(8, '#entrepreneurship'),
(9, '#food'),
(10, '#fashion');

-- FOLLOWER Table
INSERT INTO FOLLOWER (FOLLOWER_ID, USER_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- TAG Table
INSERT INTO TAG (TAG_ID, TAG_NAME) VALUES
(1, 'coding tutorial'),
(2, 'nature shot'),
(3, 'painting'),
(4, 'travel vlog'),
(5, 'food recipe'),
(6, 'fitness tips'),
(7, 'concert live'),
(8, 'startup advice'),
(9, 'fashion tips'),
(10, 'landscape');

-- GROUPP Table
INSERT INTO GROUPP (GROUP_ID, GROUP_NAME, DESCRIPTION, CREATION_DATE, STATUS, USER_ID) VALUES
(1, 'Tech Group', 'Technology lovers', '2023-01-15', 'Active', 1),
(2, 'Nature Group', 'Nature enthusiasts', '2023-01-20', 'Active', 2),
(3, 'Art Group', 'Art lovers', '2023-02-01', 'Active', 3),
(4, 'Travel Club', 'Travel discussions', '2023-02-15', 'Active', 4),
(5, 'Fitness Club', 'Fitness community', '2023-02-20', 'Active', 5),
(6, 'Music Club', 'Music fanatics', '2023-03-01', 'Active', 6),
(7, 'Startup Forum', 'Entrepreneurial ideas', '2023-03-15', 'Active', 7),
(8, 'Foodies', 'Food discussions', '2023-04-01', 'Active', 8),
(9, 'Fashionistas', 'Fashion trends', '2023-04-20', 'Active', 9),
(10, 'Photographers', 'Photography tips', '2023-05-01', 'Active', 10);

-- LIVE_EVENT Table
INSERT INTO LIVE_EVENT (EVENT_ID, EVENT_NAME, TIMESTAMP) VALUES
(1, 'Webinar on AI', '2023-06-01'), (2, 'Nature Camp', '2023-06-05'), 
(3, 'Art Exhibition', '2023-06-10'), (4, 'Travel Planning', '2023-06-15'), 
(5, 'Fitness Challenge', '2023-06-20'), (6, 'Music Jam', '2023-06-25'),
(7, 'Startup Pitching', '2023-06-30'), (8, 'Food Fest', '2023-07-05'),
(9, 'Fashion Week', '2023-07-10'), (10, 'Photo Contest', '2023-07-15');

-- ADS Table
INSERT INTO ADS (AD_ID, AD_CONTENT, STARTDATE, ENDDATE) VALUES
(1, 'AI Ad', '2023-06-01', '2023-07-01'), (2, 'Nature Gear', '2023-06-05', '2023-07-05'),
(3, 'Art Supplies', '2023-06-10', '2023-07-10'), (4, 'Travel Deals', '2023-06-15', '2023-07-15'),
(5, 'Fitness App', '2023-06-20', '2023-07-20'), (6, 'Music Instruments', '2023-06-25', '2023-07-25'),
(7, 'Startup Tools', '2023-06-30', '2023-07-30'), (8, 'Food Products', '2023-07-05', '2023-08-05'),
(9, 'Fashion Brands', '2023-07-10', '2023-08-10'), (10, 'Camera Equipment', '2023-07-15', '2023-08-15');

-- REACTIONS Table
INSERT INTO REACTIONS (REACTION_ID, REACTIONTYPE) VALUES
(1, 'Like'), (2, 'Love'), (3, 'Wow'), (4, 'Sad'), (5, 'Angry'), (6, 'Laugh'),
(7, 'Hug'), (8, 'Cheer'), (9, 'Shock'), (10, 'Confused');

-- NOTIFICATIONS Table
INSERT INTO NOTIFICATIONS (NOTIFICATION_ID, TIMESTAMP, USER_ID) VALUES
(1, '2023-06-01 08:00:00', 1), (2, '2023-06-05 09:00:00', 2),
(3, '2023-06-10 10:00:00', 3), (4, '2023-06-15 11:00:00', 4),
(5, '2023-06-20 12:00:00', 5), (6, '2023-06-25 13:00:00', 6),
(7, '2023-06-30 14:00:00', 7), (8, '2023-07-05 15:00:00', 8),
(9, '2023-07-10 16:00:00', 9), (10, '2023-07-15 17:00:00', 10);

-- POLL Table
INSERT INTO POLL (POLL_ID, QUESTIONS) VALUES
(1, 'What is your favorite programming language?'),
(2, 'Do you prefer cats or dogs?'),
(3, 'Which is better: sunrise or sunset?'),
(4, 'Favorite season of the year?'),
(5, 'Do you like coffee or tea?'),
(6, 'Which is better: iOS or Android?'),
(7, 'Do you work remotely or in the office?'),
(8, 'Your go-to social media app?'),
(9, 'Preferred vacation type: Beach or Mountains?'),
(10, 'How often do you exercise weekly?');

-- ARCHIVE Table
INSERT INTO ARCHIVE (ARCHIVE_ID, TIMESTAMP) VALUES
(1, '2023-06-01 08:30:00'), (2, '2023-06-02 10:00:00'),
(3, '2023-06-03 09:45:00'), (4, '2023-06-04 07:15:00'),
(5, '2023-06-05 11:00:00'), (6, '2023-06-06 14:20:00'),
(7, '2023-06-07 16:30:00'), (8, '2023-06-08 17:40:00'),
(9, '2023-06-09 19:10:00'), (10, '2023-06-10 20:00:00');

-- AdPerformanceMetrics Table#
INSERT INTO AdPerformanceMetrics (METRIC_ID, REGION, INTERACTIONS, AD_ID) VALUES
(1, 'North America', '150 Likes', 1), (2, 'Europe', '300 Comments', 2),
(3, 'Asia', '500 Shares', 3), (4, 'South America', '200 Likes', 4),
(5, 'Australia', '350 Interactions', 5), (6, 'Africa', '100 Comments', 6),
(7, 'North America', '400 Reactions', 7), (8, 'Europe', '250 Likes', 8),
(9, 'Asia', '500 Likes', 9), (10, 'Australia', '300 Views', 10);

-- Live_EventInteraction Table
INSERT INTO Live_EventInteraction (INTERACTION_ID, RESPONSE, EVENT_ID) VALUES
(1, 'Question about AI', 1), (2, 'Shared photos', 2),
(3, 'Feedback on art', 3), (4, 'Query about planning', 4),
(5, 'Signed up for challenge', 5), (6, 'Requested setlist', 6),
(7, 'Presentation questions', 7), (8, 'Added review', 8),
(9, 'Feedback on outfits', 9), (10, 'Submitted photos', 10);

-- NOTIFICATIONS_NOTIFICATION_TYPE Table
INSERT INTO NOTIFICATIONS_NOTIFICATION_TYPE (NOTIFICATION_TYPE, NOTIFICATION_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- POST Table
INSERT INTO POST (POST_ID, CONTENT, CAPTION, TIMESTAMP, LIKES_COUNT, COMMENTS_COUNT, USER_ID, AD_ID, ARCHIVE_ID) VALUES
(1, 'post1.jpg', 'AI Revolution', '2023-06-01 08:00:00', 100, 20, 1, 1, 1),
(2, 'post2.jpg', 'Nature Beauty', '2023-06-02 09:30:00', 150, 35, 2, 2, 2),
(3, 'post3.jpg', 'Art Therapy', '2023-06-03 10:15:00', 120, 25, 3, 3, 3),
(4, 'post4.jpg', 'Explore the World', '2023-06-04 08:45:00', 200, 40, 4, 4, 4),
(5, 'post5.jpg', 'Fitness Day', '2023-06-05 09:00:00', 250, 50, 5, 5, 5),
(6, 'post6.jpg', 'Music Memories', '2023-06-06 11:15:00', 300, 75, 6, 6, 6),
(7, 'post7.jpg', 'Startup Hustle', '2023-06-07 13:00:00', 180, 30, 7, 7, 7),
(8, 'post8.jpg', 'Tasty Bites', '2023-06-08 14:30:00', 220, 45, 8, 8, 8),
(9, 'post9.jpg', 'Fashion Finesse', '2023-06-09 16:00:00', 280, 60, 9, 9, 9),
(10, 'post10.jpg', 'Landscapes Galore', '2023-06-10 17:15:00', 350, 85, 10, 10, 10);

-- COMMENT Table
INSERT INTO COMMENT (COMMENT_ID, TEXT, TIMESTAMP, POST_ID) VALUES
(1, 'Amazing!', '2023-06-01 08:30:00', 1), (2, 'Wow!', '2023-06-02 09:45:00', 2),
(3, 'So beautiful!', '2023-06-03 10:30:00', 3), (4, 'Love this', '2023-06-04 11:00:00', 4),
(5, 'Great idea!', '2023-06-05 11:30:00', 5), (6, 'Awesome', '2023-06-06 12:15:00', 6),
(7, 'Inspired!', '2023-06-07 13:30:00', 7), (8, 'Delicious!', '2023-06-08 14:45:00', 8),
(9, 'Elegant!', '2023-06-09 15:00:00', 9), (10, 'Amazing shot!', '2023-06-10 16:15:00', 10);

-- STORY Table
INSERT INTO STORY (STORY_ID, CONTENT, TIMESTAMP, USER_ID, EVENT_ID) VALUES
(1, 'Story about AI', '2023-06-01 18:00:00', 1, 1), (2, 'Nature capture', '2023-06-02 19:00:00', 2, 2),
(3, 'Art creation', '2023-06-03 20:00:00', 3, 3), (4, 'Travel tips', '2023-06-04 21:00:00', 4, 4),
(5, 'Fitness Routine', '2023-06-05 22:00:00', 5, 5), (6, 'Concert prep', '2023-06-06 23:00:00', 6, 6),
(7, 'Startup diary', '2023-06-07 23:00:00', 7, 7), (8, 'Recipe Reel', '2023-06-08 01:00:00', 8, 8),
(9, 'Style Trend', '2023-06-09 02:00:00', 9, 9), (10, 'Sunset Story', '2023-06-10 03:00:00', 10, 10);

-- STORY_REACTION Table
INSERT INTO STORY_REACTION (STORY_ID, REACTION_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- MESSAGE Table
INSERT INTO MESSAGE (MESSAGE_ID, CONTENT, TIMESTAMP, POLL_ID) VALUES
(1, 'What is your favorite feature?', '2023-06-01 15:00:00', 1),
(2, 'What do you enjoy the most?', '2023-06-02 16:00:00', 2),
(3, 'Do you prefer coffee?', '2023-06-03 17:00:00', 3),
(4, 'Sunrise or sunset?', '2023-06-04 18:00:00', 4),
(5, 'Office or Remote?', '2023-06-05 19:00:00', 5),
(6, 'Favorite app?', '2023-06-06 20:00:00', 6),
(7, 'Exercise habits?', '2023-06-07 21:00:00', 7),
(8, 'Beach or mountains?', '2023-06-08 22:00:00', 8),
(9, 'iOS or Android?', '2023-06-09 23:00:00', 9),
(10, 'Daily productivity tip?', '2023-06-10 23:59:00', 10);

-- POST_HASHTAG Table
INSERT INTO POST_HASHTAG (POST_ID, HASHTAG_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- REPORT Table
INSERT INTO REPORT (REPORT_ID, POST_ID, TIMESTAMP, REASON) VALUES
(1, 1, '2023-06-01 10:00:00', 'Inappropriate content'),
(2, 2, '2023-06-02 11:00:00', 'Spam'),
(3, 3, '2023-06-03 12:00:00', 'Hate speech'),
(4, 4, '2023-06-04 13:00:00', 'Violates policy'),
(5, 5, '2023-06-05 14:00:00', 'Misleading information'),
(6, 6, '2023-06-06 15:00:00', 'Graphic content'),
(7, 7, '2023-06-07 16:00:00', 'Scam'),
(8, 8, '2023-06-08 17:00:00', 'Fake news'),
(9, 9, '2023-06-09 18:00:00', 'Copyright violation'),
(10, 10, '2023-06-10 19:00:00', 'Harassment');

-- LIKES TABLE
INSERT INTO LIKES (LIKE_ID, POST_ID) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


-- LIKES_POST Table
INSERT INTO LIKES_POST (USER_ID, LIKE_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);


-- COMMENTS Table
INSERT INTO COMMENTS (USER_ID, COMMENT_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- SENDS Table
INSERT INTO SENDS (USER_ID, MESSAGE_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- POST_TAG Table
INSERT INTO POST_TAG (POST_ID, TAG_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
