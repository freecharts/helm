# PpostgreSQL

Helm chart to deploy PostgreSQL as standard way single instance or as ha mode with Pgpool II frontend.

## Sequence

primary KO
    ↓
sidecar détecte
    ↓
choisit le replica le plus prioritaire
    ↓
kubectl exec ... SELECT pg_promote()
    ↓
attend pg_is_in_recovery() = false
    ↓
label postgres-role=primary
    ↓
reconfigure les autres replicas
    ↓
pcp_attach_node
