-- Q14: Consistency levels ONE, QUORUM, ALL
-- Use a multi-node cluster to observe meaningful differences between levels.
-- A single-node lab cluster with RF=1 cannot demonstrate quorum/replica trade-offs.
CREATE KEYSPACE IF NOT EXISTS ConsistencyDB
WITH replication = {'class': 'NetworkTopologyStrategy', 'datacenter1': 3};
USE ConsistencyDB;

CREATE TABLE IF NOT EXISTS SampleValues (
    item_id text PRIMARY KEY,
    item_value text
);

CONSISTENCY ONE;
INSERT INTO SampleValues (item_id, item_value) VALUES ('item1', 'value-one');
SELECT * FROM SampleValues WHERE item_id = 'item1';

CONSISTENCY QUORUM;
UPDATE SampleValues SET item_value = 'value-quorum' WHERE item_id = 'item1';
SELECT * FROM SampleValues WHERE item_id = 'item1';

CONSISTENCY ALL;
SELECT * FROM SampleValues WHERE item_id = 'item1';
-- If fewer than all required replicas are available, ALL reads/writes may fail.
-- Ensure 'datacenter1' matches the actual datacenter name in your cluster.
