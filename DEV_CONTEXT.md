DEV_CONTEXT.md — Lynra GreyNote
🧠 Project Overview
Lynra GreyNote is a fully offline, security-first personal vault application.
Core principle:
All data belongs to the user and never leaves the device.
No cloud.
No analytics.
No tracking.
No background sync.
🔐 Security Philosophy
1. Local-Only Architecture
All data is stored locally on device
No API calls
No backend dependency
No telemetry
2. Zero-Trust UI Model
Even if:
App is opened
Device is unlocked
👉 Sensitive data may still be hidden
This is achieved via:
Vault Word (content-level lock)
🏗️ Data Architecture
Storage Layers
Layer
Technology
Purpose
Vault Data
SQLite (sqflite)
Main encrypted data
Secrets
flutter_secure_storage
Keys & settings
UI State
Memory
Temporary states
🔐 Encryption Model
Current Implementation
Each vault item contains:
payload → encrypted string
Encryption handled before DB write
Decryption happens only when needed
👉 Result:
DB is unreadable even if accessed directly
🔑 Key Principles
No plaintext sensitive data stored
Encryption happens before persistence
Decryption happens only for UI rendering
Export uses already encrypted payload
🔐 Authentication Layers
Lynra uses multi-layered protection model:
1. Primary Lock (Pattern / PIN)
First gate
Blocks app access
2. Secondary PIN / Biometrics
Faster access layer
Device-level integration
Optional but recommended
3. Vault Word (Content Lock) ⭐
Most important unique feature
Purpose:
Hide actual content even after app is opened
Behavior:
When enabled:
UI shows fake / meaningless text
When unlocked:
Real content is revealed
Important:
Does NOT re-encrypt data
Only controls visibility layer
Security Impact:
Protects against:
Shoulder surfing
Casual access
Social engineering
🎭 Content Masking System
When Vault Word is active:
Field
Behavior
Title
Replaced with fake text
Username
Replaced
Notes
Replaced
IBAN
Replaced
Password
Already hidden
Fake data examples:
"system buffer"
"encrypted block"
"null segment"
🔄 Session Model
isVaultUnlocked = true → temporary
Reset conditions:
App restart
Screen rebuild (depending on implementation)
👉 Vault Word is session-based
📦 Export / Import System
Export
Exports:
vault table
collections table
Format:
JSON
{
  "vault": [...],
  "collections": [...]
}
Data remains encrypted
Import
Strategy: Full Replace
Deletes current data
Inserts imported data
👉 No merge logic (intentional simplicity)
🔐 Export Security
Payload is already encrypted
No additional encryption layer (V1)
Future Consideration:
Optional export password
Encrypted JSON backup
🧠 Threat Model
Protected Against:
Device theft (basic level)
Unauthorized casual access
Screenshot / visual exposure
DB extraction (due to encryption)
Not Fully Protected Against:
Rooted device + memory inspection
Advanced reverse engineering
Key extraction (if device compromised)
⚠️ Security Trade-offs
Feature
Trade-off
Offline-only
No sync / backup
No cloud
User responsible for backup
Vault Word
UI-only protection (not cryptographic)
🔮 Future Security Enhancements
High Priority
Export file encryption (AES + user password)
Secure key derivation (PBKDF2 / Argon2)
App auto-lock on background
Medium
Screenshot blocking (Android FLAG_SECURE)
Clipboard auto-clear
Failed unlock attempt tracking
Advanced
Decoy mode (fake vault)
Stealth mode (disguised app UI)
🧩 UX Security Design
Goals:
Security without friction
Power without complexity
Decisions:
No overwhelming settings
Clear mental model:
Lock → open app
Vault Word → reveal content
🎯 Product Positioning
Lynra is NOT:
a cloud password manager
a sync tool
a team product
Lynra IS:
A personal, private, offline vault.
🧪 Testing Focus
Critical Tests
App restart → Vault Word resets
Import → correct restore
Export → valid JSON
Masking → no real data leak
Unlock → immediate UI update
📌 Development Rules
No plaintext sensitive logs
No debug prints with secrets
No accidental API usage
Always assume device is hostile
🏁 Summary
Lynra is built on one principle:
Privacy is not a feature. It is the foundation.
