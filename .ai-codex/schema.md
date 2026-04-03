# Database Schema — AgroControl SQLite (v12)

## sectors
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| name | TEXT | NOT NULL |
| number | INTEGER | NOT NULL |
| production_chain | TEXT | NOT NULL |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## entries
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| date | TEXT | NOT NULL |
| description | TEXT | NOT NULL |
| quantity | REAL | NOT NULL |
| unit_value | REAL | NOT NULL |
| unit | TEXT | |
| venda_prazo_date | TEXT | |
| venda_prazo_notificacao | INTEGER | NOT NULL DEFAULT 0 |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## rainfall
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| date | TEXT | NOT NULL |
| rainfall | REAL | NOT NULL |
| notes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## pest_monitoring
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| date | TEXT | NOT NULL |
| pest_name | TEXT | NOT NULL |
| attack_level | INTEGER | NOT NULL |
| notes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## pest_control
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| batch_id | TEXT | |
| date | TEXT | NOT NULL |
| target_pest | TEXT | NOT NULL |
| product_name | TEXT | NOT NULL |
| active_ingredient | TEXT | |
| dose_l_per_ha | REAL | |
| spray_volume_l_per_ha | REAL | |
| total_product_l | REAL | |
| labor_equipment | TEXT | |
| fuel_l | REAL | |
| responsible | TEXT | |
| notes | TEXT | |
| scheduled_time | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## global_expenses
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| date | TEXT | NOT NULL |
| category | TEXT | NOT NULL |
| description | TEXT | NOT NULL |
| amount | REAL | NOT NULL |
| notes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## financings
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| description | TEXT | NOT NULL |
| principal | REAL | NOT NULL |
| interest_rate | REAL | NOT NULL |
| interest_period | TEXT | NOT NULL DEFAULT 'mensal' |
| interest_type | TEXT | NOT NULL DEFAULT 'simples' |
| start_date | TEXT | NOT NULL |
| due_date | TEXT | NOT NULL |
| paid_amount | REAL | NOT NULL DEFAULT 0.0 |
| status | TEXT | NOT NULL DEFAULT 'ativo' |
| notes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## batches
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| culture | TEXT | NOT NULL |
| start_date | TEXT | NOT NULL |
| end_date | TEXT | |
| status | TEXT | NOT NULL DEFAULT 'active' |
| notes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## fertilization
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| batch_id | TEXT | |
| date | TEXT | NOT NULL |
| product_name | TEXT | NOT NULL |
| type | TEXT | NOT NULL |
| dosage | REAL | |
| dosage_unit | TEXT | |
| total_amount | REAL | |
| application_method | TEXT | |
| labor_equipment | TEXT | |
| fuel_l | REAL | |
| responsible | TEXT | |
| notes | TEXT | |
| scheduled_time | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## bovines
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| tag | TEXT | NOT NULL |
| sisbov_id | TEXT | |
| nome | TEXT | |
| sexo | TEXT | NOT NULL |
| raca | TEXT | |
| origem | TEXT | |
| data_nascimento | TEXT | |
| peso_atual | REAL | |
| data_peso_atual | TEXT | |
| vendido | INTEGER | NOT NULL DEFAULT 0 |
| data_venda | TEXT | |
| valor_venda | REAL | |
| comprador | TEXT | |
| observacoes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## bovine_vaccinations
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| bovine_id | TEXT | NOT NULL, FK → bovines.id CASCADE |
| vacina | TEXT | NOT NULL |
| data | TEXT | NOT NULL |
| proxima_data | TEXT | |
| lote | TEXT | |
| observacoes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## colmeias
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| numero | TEXT | NOT NULL |
| tipo | TEXT | NOT NULL DEFAULT 'Langstroth' |
| data_instalacao | TEXT | |
| status | TEXT | NOT NULL DEFAULT 'ativa' |
| rainha_presente | INTEGER | NOT NULL DEFAULT 1 |
| data_ultimo_manejo | TEXT | |
| observacoes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## hive_feedings
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| hive_id | TEXT | NOT NULL, FK → colmeias.id CASCADE |
| data | TEXT | NOT NULL |
| tipo_alimento | TEXT | NOT NULL |
| quantidade | REAL | |
| unidade | TEXT | |
| observacoes | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## animal_treatments
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| produtor_id | TEXT | |
| sector_id | TEXT | NOT NULL, FK → sectors.id CASCADE |
| date | TEXT | NOT NULL |
| animal_type | TEXT | NOT NULL DEFAULT 'outro' |
| affected_animals | TEXT | |
| target_pest | TEXT | NOT NULL |
| product_name | TEXT | NOT NULL |
| active_ingredient | TEXT | |
| dose | REAL | |
| dose_unit | TEXT | |
| total_amount | REAL | |
| responsible | TEXT | |
| notes | TEXT | |
| scheduled_time | TEXT | |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
| deleted_at | TEXT | soft-delete |

## pending_uploads
| Column | Type | Constraints |
|--------|------|-------------|
| id | TEXT | PK |
| table_name | TEXT | NOT NULL |
| record_id | TEXT | NOT NULL |
| operation | TEXT | NOT NULL |
| payload | TEXT | |
| created_at | TEXT | NOT NULL |
