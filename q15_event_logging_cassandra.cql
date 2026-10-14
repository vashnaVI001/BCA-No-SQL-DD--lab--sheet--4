-- Q15: Mini-project — column-oriented event logging application in Cassandra
-- Demonstrates create, insert, query, update, delete and design trade-offs.
CREATE KEYSPACE IF NOT EXISTS EventLoggingProject
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE EventLoggingProject;

CREATE TABLE IF NOT EXISTS EventsByUser (
    user_id text,
    event_time timestamp,
    event_id text,
    event_type text,
    status text,
    details text,
    PRIMARY KEY ((user_id), event_time, event_id)
) WITH CLUSTERING ORDER BY (event_time DESC, event_id ASC);

INSERT INTO EventsByUser (user_id, event_time, event_id, event_type, status, details)
VALUES ('U101', '2026-10-14T09:00:00Z', 'EVT001', 'LOGIN', 'SUCCESS', 'Android app');
INSERT INTO EventsByUser (user_id, event_time, event_id, event_type, status, details)
VALUES ('U101', '2026-10-14T09:05:00Z', 'EVT002', 'VIEW_PAGE', 'SUCCESS', 'Home page');
INSERT INTO EventsByUser (user_id, event_time, event_id, event_type, status, details)
VALUES ('U102', '2026-10-14T09:10:00Z', 'EVT003', 'LOGIN', 'FAILED', 'Invalid password');

-- Read a user's events over a time range
SELECT * FROM EventsByUser
WHERE user_id = 'U101'
AND event_time >= '2026-10-14T09:00:00Z'
AND event_time <= '2026-10-14T10:00:00Z';

-- Update a known primary-key row
UPDATE EventsByUser SET status = 'REVIEWED'
WHERE user_id = 'U102'
AND event_time = '2026-10-14T09:10:00Z'
AND event_id = 'EVT003';

-- Delete a known primary-key row
DELETE FROM EventsByUser
WHERE user_id = 'U101'
AND event_time = '2026-10-14T09:05:00Z'
AND event_id = 'EVT002';

SELECT * FROM EventsByUser WHERE user_id = 'U101';

-- Design notes:
-- * Consistency: client chooses consistency level (ONE/QUORUM/ALL).
-- * Availability: depends on reachable replicas and chosen consistency level.
-- * Transactions: single-partition operations are atomic/isolation-scoped to a partition;
--   Cassandra is not a general relational transaction engine.
-- * Query features: model tables around queries and primary keys; avoid unrestricted scans.
-- * Scaling: partition key user_id distributes users; very high-volume users may need bucketing.
-- Production deployments should use NetworkTopologyStrategy and a suitable RF.
