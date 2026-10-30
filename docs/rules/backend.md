# Backend

Ignore this document if this is not a backend application.

#### Health Checks and Smoke Tests
Backends expose health checks and smoke tests at URLs:
- `/health` is the liveness probe: 200 with a body of `OK`.
- `/status` returns 200 if everything is fine and 503 if something is down, preferably by failing naturally at whatever is down. It may render a simple page with green, orange, and red dots. Every integration, database, and internal or external service needs a status.

#### Databases
- **ORM:** use an ORM and keep SQL in the app to a minimum. Models are the only place SQL belongs, with a model file per entity. Follow the same standards as Data Files above.
- **Migrations:** schema changes go through migrations and stay compatible with rollback.

#### Initializers
Start-up code, especially code that instantiates shared services used by many controllers, lives in a dedicated initialization location. This is also the preferred place to parse environment variables, which should not otherwise appear in the backend.

#### Routes
Routes don't end in technology file extensions (`.html`, `.php`, `.py`, `.rb`). Use a routing layer to map routes to controllers.

#### API
Controllers build JSON from the models' own serialization and are covered by request tests.