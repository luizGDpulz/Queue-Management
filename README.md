# QueueMaster

A lightweight hybrid queue and appointment management system.

Premise
-------
QueueMaster lets customers either join a live walk-in queue or schedule appointments. The system reconciles both flows so scheduled customers get priority at their booked time while live queue members fill available slots.

Quick Summary
-------------
- **Backend:** PHP (Apache) — RESTful JSON API
- **Web frontend:** HTML + Tailwind CSS + vanilla JavaScript (AJAX via `fetch` / XHR; real-time via SSE/WebSocket optional)
- **Mobile:** Kotlin + Jetpack Compose
- **Database:** MySQL / MariaDB
- **Database:** MariaDB

Key features
------------
- Multi-role authentication (admin / attendant / client)
- Walk-in queue entries with atomic position calculation
- Appointments per service/professional with conflict checks
- Priority rules: appointments are prioritized in a configurable grace window
- Real-time updates via SSE/WebSocket or AJAX polling

Files
-----
- Proposal (English): `docs/PROPOSE_EN.md`
- Original Portuguese proposal: `docs/PROPOSE.md`