# BCA305P-AS01 — NoSQL Database Design Lab Sheet 4

This repository contains code/examples for all 15 questions in the attached lab sheet:
- Questions 1–10: Apache HBase shell commands
- Questions 11–14: Apache Cassandra CQL
- Question 15: a combined Event Logging example using Cassandra

## Requirements
- Apache HBase running for `.hbase` examples.
- Apache Cassandra running and `cqlsh` available for `.cql` examples.
- Commands are examples for a local development environment. Change hostnames, versions, and replication settings to match your installation.

## Run
- HBase: open `hbase shell`, then paste the contents of the relevant `.hbase` file.
- Cassandra: run `cqlsh`, then execute the relevant `.cql` file with `SOURCE 'filename.cql';` (from the cqlsh working directory), or paste the statements directly.
- `q15_event_logging_cassandra.cql` is a complete mini-project example.

## Notes
- Cassandra `SimpleStrategy` with replication factor 1 is suitable only for a single-node lab setup, not production.
- Cassandra queries must follow the table's primary-key design; the event-log example uses a partition key plus clustering timestamp.
- HBase region splits/distribution depend on cluster configuration and data volume; pre-splitting creates initial regions but does not itself prove live load balancing.
