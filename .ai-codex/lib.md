# Library Index — AgroControl

## Models (`lib/models/`)

### Sector — `models/sector.dart`
Fields: `id`, `name`, `number`, `productionChain`, `latitude`, `longitude`
Methods: `toMap()`, `fromMap()`, `copyWith()`

### Entry — `models/entry.dart`
Fields: `id`, `sectorId`, `date`, `description`, `quantity`, `unitValue`, `unit`, `vendaPrazoDate`, `vendaPrazoNotificacao`
Getters: `totalValue`
Methods: `toMap()`, `fromMap()`

### RainfallEntry — `models/rainfall.dart`
Fields: `id`, `date`, `rainfall`, `notes`
Methods: `toMap()`, `fromMap()`

### PestMonitoring — `models/pest_monitoring.dart`
Fields: `id`, `sectorId`, `date`, `pestName`, `attackLevel`, `notes`, `affectedAnimals`
Methods: `toMap()`, `fromMap()`

### PestControl — `models/pest_control.dart`
Fields: `id`, `sectorId`, `batchId`, `date`, `targetPest`, `productName`, `activeIngredient`, `doseLPerHa`, `sprayVolumeLPerHa`, `totalProductL`, `laborEquipment`, `fuelL`, `responsible`, `notes`, `scheduledTime`
Methods: `toMap()`, `fromMap()`

### GlobalExpense — `models/global_expense.dart`
Fields: `id`, `date`, `category`, `description`, `amount`, `notes`
Methods: `toMap()`, `fromMap()`

### Financing — `models/financing.dart`
Fields: `id`, `description`, `principal`, `interestRate`, `interestPeriod`, `interestType`, `startDate`, `dueDate`, `paidAmount`, `status`, `notes`
Getters: `periods`, `montanteTotal`, `saldoDevedor`, `progressPercent`
Methods: `toMap()`, `fromMap()`

### Batch — `models/batch.dart`
Fields: `id`, `sectorId`, `culture`, `startDate`, `endDate`, `status`, `notes`, `produtorId`, `createdAt`, `updatedAt`, `deletedAt`
Methods: `toMap()`, `fromMap()`, `copyWith()`

### Fertilization — `models/fertilization.dart`
Fields: `id`, `sectorId`, `batchId`, `date`, `productName`, `type`, `dosage`, `dosageUnit`, `totalAmount`, `applicationMethod`, `laborEquipment`, `fuelL`, `responsible`, `notes`, `scheduledTime`
Static: `types` (List), `applicationMethods` (List), `unitForType(String type)`
Methods: `toMap()`, `fromMap()`, `copyWith()`

### Bovine — `models/bovine.dart`
Fields: `id`, `sectorId`, `produtorId`, `tag`, `sisbovId`, `nome`, `sexo`, `raca`, `origem`, `dataNascimento`, `pesoAtual`, `dataPesoAtual`, `vendido`, `dataVenda`, `valorVenda`, `comprador`, `observacoes`, `createdAt`, `updatedAt`, `deletedAt`
Methods: `toMap()`, `fromMap()`

### BovineVaccination — `models/bovine_vaccination.dart`
Fields: `id`, `bovineId`, `produtorId`, `vacina`, `data`, `proximaData`, `lote`, `observacoes`, `createdAt`, `updatedAt`, `deletedAt`
Methods: `toMap()`, `fromMap()`

### Hive — `models/hive.dart`
Fields: `id`, `sectorId`, `produtorId`, `numero`, `tipo`, `dataInstalacao`, `status`, `rainhaPresente`, `dataUltimoManejo`, `observacoes`, `createdAt`, `updatedAt`, `deletedAt`
Methods: `toMap()`, `fromMap()`

### HiveFeeding — `models/hive_feeding.dart`
Fields: `id`, `hiveId`, `produtorId`, `data`, `tipoAlimento`, `quantidade`, `unidade`, `observacoes`, `createdAt`, `updatedAt`, `deletedAt`
Methods: `toMap()`, `fromMap()`

### AnimalTreatment — `models/animal_treatment.dart`
Fields: `id`, `sectorId`, `date`, `animalType`, `affectedAnimals`, `targetPest`, `productName`, `activeIngredient`, `dose`, `doseUnit`, `totalAmount`, `responsible`, `notes`, `scheduledTime`
Methods: `toMap()`, `fromMap()`

---

## Database / Repositories (`lib/database/`)

### DatabaseHelper — `database/db_helper.dart`
Singleton. SQLite v12. Direct CRUD for all tables.

### DataRepository (abstract) — `database/data_repository.dart`
Interface for all repositories. All methods async Future.
Covers: Sectors, Entries, Rainfall, PestMonitoring, PestControl, GlobalExpense, Financing, Batches, Fertilization, Bovines, BovineVaccinations, Hives, HiveFeedings, AnimalTreatments.

### SqliteRepository — `database/sqlite_repository.dart`
Implements `DataRepository`. Delegates to `DatabaseHelper`. Used for guest/offline mode.

### SupabaseRepository — `database/supabase_repository.dart`
Implements `DataRepository`. Cloud sync for authenticated users.

### ReadOnlySupabaseRepository — `database/tecnico_supabase_repository.dart`
Implements `DataRepository`. Read-only; used by Technician mode to view a producer's data.

### TechnicianWriteRepository — `database/tecnico_write_repository.dart`
Extends `ReadOnlySupabaseRepository`. Adds write access when technician enables editing.

### ResilientRepository — `database/resilient_repository.dart`
Implements `DataRepository`. Wraps another repository with error recovery/fallback.

### BackupService — `database/backup_service.dart`
Singleton: `BackupService.instance`
Sync strategy: LWW via `updated_at`; soft-delete via `deleted_at`
Key methods: `startPeriodicSync()`, `stopPeriodicSync()`, `onAppPause()`, `claimOrphanRecords(userId)`

### OfflineQueue — `database/offline_queue.dart`
Manages pending operations queue for offline → online sync.

### SyncStatus — `database/sync_status.dart`
Extends `ChangeNotifier`. UI-facing sync progress notifications.

### ConnectivityState — `database/connectivity_state.dart`
Tracks network connectivity via `connectivity_plus`.

---

## Utilities (`lib/utils/`)

### TechnicianSession — `utils/tecnico_session.dart`
Singleton, extends `ChangeNotifier`. Manages technician role state.
Properties: `isActive`, `canEdit`, `viewedProducerId`, `viewedProducerName`, `activeVinculoId`
Methods: `enter()`, `enableEditing()`, `exit()`

### ChatService — `utils/chat_service.dart`
AI chat via Supabase Edge Function `chat-agro`.
Methods: `sendMessage(String userMessage)`, `clearHistory()`
Model: `ChatMessage` — `role` (user/assistant), `content`

### PlanManager — `utils/plan_manager.dart`
Static. Premium subscription checks with 5-min cache.
Methods: `isPremium()`, `getCurrentPlan()`, `clearCache()`

### ExportService — `utils/export_service_io.dart` / `export_service_web.dart`
Platform-specific Excel export.
Methods: `exportToExcel()`

### InstructionsManager — `utils/instructions_manager.dart`
Static. `shouldShowInstructions(screenType, db)` — true when table is empty.

### ReviewManager — `utils/review_manager.dart`
In-app review trigger. Threshold: 20 entries, 30-day cooldown.
Methods: `incrementEntryCount()`, `checkAndRequestReview(context)`
