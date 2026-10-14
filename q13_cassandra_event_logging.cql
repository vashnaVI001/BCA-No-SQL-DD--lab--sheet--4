-- Q13: Event log queryable by user and time period
CREATE KEYSPACE IF NOT EXISTS EventDB
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE EventDB;

CREATE TABLE IF NOT EXISTS EventsByUser (
    user_id text,
    event_time timestamp,
    event_id text,
    event_type text,
    status text,
    PRIMARY KEY ((user_id), event_time, event_id)
) WITH CLUSTERING ORDER BY (event_time DESC, event_id ASC);

INSERT INTO EventsByUser (user_id, event_time, event_id, event_type, status)
VALUES ('U101', '2026-10-14T09:00:00Z', 'EVT001', 'LOGIN', 'SUCCESS');
INSERT INTO EventsByUser (user_id, event_time, event_id, event_type, status)
VALUES ('U101', '2026-10-14T09:10:00Z', 'EVT002', 'VIEW_PAGE', 'SUCCESS');
INSERT INTO EventsByUser (user_id, event_time, event_id, event_type, status)
VALUES ('U102', '2026-10-14T09:15:00Z', 'EVT003', 'LOGIN', 'FAILED');

-- Query a particular user's events within a time range (partition key is specified).
SELECT * FROM EventsByUser
WHERE user_id = 'U101'
AND event_time >= '2026-10-14T09:00:00Z'
AND event_time <= '2026-10-14T09:30:00Z';
