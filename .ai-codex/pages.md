# Page Tree — AgroControl

## Auth
| Screen | File | Description |
|--------|------|-------------|
| LoginScreen | `screens/login.dart` | Email/password login |
| RegisterScreen | `screens/register.dart` | New user registration |
| TermsOfUseScreen | `screens/terms_of_use_screen.dart` | Terms of service |

## Main Shell
| Screen | File | Description |
|--------|------|-------------|
| HomeScreen | `screens/home.dart` | Bottom nav host: Dashboard, Production, Finance, Rainfall, Settings |
| DashboardPage | `screens/dashboard_page.dart` | Analytics and activity overview |
| SettingsScreen | `screens/settings.dart` | App preferences and account |

## Production
| Screen | File | Description |
|--------|------|-------------|
| ProductionScreen | `screens/production.dart` | Sector list by production chain |
| SectorScreen | `screens/sector_screen.dart` | Sector detail + entry logging |
| TraceabilityScreen | `screens/traceability_screen.dart` | Batch/lote management + QR generation |

## Pest & Field Management (`screens/pestsc/`)
| Screen | File | Description |
|--------|------|-------------|
| PestScreen | `screens/manejo.dart` | Pest management hub/menu |
| MonitoringEntryScreen | `screens/pestsc/monitoring_screen.dart` | Log pest surveillance observation |
| ControlEntryScreen | `screens/pestsc/control_screen.dart` | Log pesticide application |
| FertilizationEntryScreen | `screens/pestsc/fertilization_screen.dart` | Log fertilizer application |
| AnimalTreatmentEntryScreen | `screens/pestsc/animal_treatment_screen.dart` | Log animal health treatment |

## Livestock
| Screen | File | Description |
|--------|------|-------------|
| BovineScreen | `screens/bovine_screen.dart` | Cattle list + vaccination records |
| HiveScreen | `screens/hive_screen.dart` | Beehive list + feeding records |

## Finance (`screens/financec/`)
| Screen | File | Description |
|--------|------|-------------|
| FinanceScreen | `screens/finance_screen.dart` | Expense and financing dashboard |
| GlobalExpenseFormScreen | `screens/financec/global_expense_form_screen.dart` | Create/edit global expense |
| FinancingFormScreen | `screens/financec/financing_form_screen.dart` | Create/edit loan/financing |

## Environmental
| Screen | File | Description |
|--------|------|-------------|
| RainfallScreen | `screens/rains.dart` | Rainfall log and analytics |

## Communication (`screens/mensagens/`)
| Screen | File | Description |
|--------|------|-------------|
| ChatScreen | `screens/chat_screen.dart` | AgroBot AI chat |
| MensagensScreen | `screens/mensagens/mensagens_screen.dart` | Notifications/messages inbox |
| MensagemComposeScreen | `screens/mensagens/mensagem_compose_screen.dart` | Compose message |

## Technician Mode (`screens/tecnico/`)
| Screen | File | Description |
|--------|------|-------------|
| TechnicianModeScaffold | `screens/tecnico/tecnico_mode_scaffold.dart` | Wrapper scaffold for technician view |
| TechnicianProducerListScreen | `screens/tecnico/tecnico_producer_list_screen.dart` | List of linked producers to view |
| VisitListScreen | `screens/tecnico/visit_list_screen.dart` | Scheduled/logged field visits |
| VisitFormScreen | `screens/tecnico/visit_list_screen.dart` | Visit data entry form |

## Producer (`screens/producer/`)
| Screen | File | Description |
|--------|------|-------------|
| ProducerCodeScreen | `screens/producer/producer_code_screen.dart` | Display/manage producer access code |
| ProducerTecnicoListScreen | `screens/producer/producer_tecnico_list_screen.dart` | Linked technicians for this producer |

## Location
| Screen | File | Description |
|--------|------|-------------|
| LocationPickerScreen | `screens/location_picker_screen.dart` | Map-based GPS location picker |
