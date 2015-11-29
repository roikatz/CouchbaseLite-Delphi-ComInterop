# CouchbaseLite-Delphi-ComInterop
A bridge from those who need to run Couchbase Lite on delphi

# Assumptions
1. You have Couchbase Server Installation
2. You have installed Couchbase sync gateway

# Usage
0. In the code - localhost for syncGateway.
1. Compile the dotNet project (the CouchbaseLiteManager)
2. Copy the product of the compilation to a safe place
3. register the dll (%Windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe /codebase /pathToDll /tlb)
4. Import Component to the Delphi project, choose create unit.
5. run SyncGateway -> from installation directory "Sync_gateway.exe config.json"

# In Delphi
* Don't forget to CoInitialize and Uninitialize when needed.

